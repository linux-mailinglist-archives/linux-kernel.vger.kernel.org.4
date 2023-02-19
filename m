Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1038869C2DE
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 23:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjBSW1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 17:27:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbjBSW1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 17:27:21 -0500
X-Greylist: delayed 576 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 19 Feb 2023 14:27:20 PST
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A9F18B06
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 14:27:19 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id E59F6101958F1;
        Sun, 19 Feb 2023 23:17:37 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id AFEC53657D; Sun, 19 Feb 2023 23:17:37 +0100 (CET)
Date:   Sun, 19 Feb 2023 23:17:37 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Orlando Chamberlain <orlandoch.dev@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Seth Forshee <sforshee@kernel.org>,
        Aditya Garg <gargaditya08@live.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Kerem Karabay <kekrby@gmail.com>
Subject: Re: [PATCH v3 3/5] apple-gmux: Use GMSP acpi method for interrupt
 clear
Message-ID: <20230219221737.GA17355@wunner.de>
References: <20230218132007.3350-1-orlandoch.dev@gmail.com>
 <20230218132007.3350-4-orlandoch.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230218132007.3350-4-orlandoch.dev@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 19, 2023 at 12:20:05AM +1100, Orlando Chamberlain wrote:
> This is needed for interrupts to be cleared correctly on MMIO based
> gmux's. It is untested if this helps/hinders other gmux types, so
> currently this is only enabled for the MMIO gmux's.
> 
> There is also a "GMLV" acpi method, and the "GMSP" method can be called
> with 1 as its argument, but the purposes of these aren't known and they
> don't seem to be needed.

GMLV and GMSP access a GPIO on the PCH which is connected to the
GMUX_INT pin of the gmux microcontroller.  I've just verified that
in the schematics of my MBP9,1.

GMLV reads the value of the GPIO ("level").
GMSP likely sets the value ("set polarity").

On my MBP9,1 (indexed gmux), if the gmux controller signals an interrupt,
the platform signals a notification:

  Scope (\_GPE)
  {
      Method (_L16, 0, NotSerialized)  // _Lxx: Level-Triggered GPE
      {
          Notify (\_SB.PCI0.LPCB.GMUX, 0x80) // Status Change
      }
  }

Comparing this to the MBP13,3 and MBP16,1, the GPE method differentiates
between the OS type:  On Darwin, only a notification is signaled,
whereas on other OSes, the GPIO's value is read and then inverted:

  Scope (\_GPE)
  {
      Method (_L15, 0, NotSerialized)  // _Lxx: Level-Triggered GPE, xx=0x00-0xFF
      {
          If (OSDW ())
          {
              Notify (\_SB.PCI0.LPCB.GPUC, 0x80) // Status Change
          }
          ElseIf ((\_SB.GGII (0x03000015) == One))
          {
              \_SB.SGII (0x03000015, Zero)
          }
          Else
          {
              \_SB.SGII (0x03000015, One)
          }
      }
  }

Linux masquerades as Darwin, so ends up in the notification-only
code path.

Does macOS execute the GMSP method as well?  Have you disassembled
the gmux driver?  All vital information that belongs in the commit
message and/or a code comment.


> +static int gmux_call_acpi_gmsp(struct apple_gmux_data *gmux_data, int arg)
> +{
> +	acpi_status status = AE_OK;
> +	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
> +	struct acpi_object_list arg_list = { 1, &arg0 };
> +
> +	arg0.integer.value = arg;
> +
> +	status = acpi_evaluate_object(gmux_data->dhandle, "GMSP", &arg_list, NULL);

Can this be simplified by using acpi_execute_simple_method() or
one of the other helpers provided by drivers/acpi/utils.c?


> @@ -537,6 +561,8 @@ static void gmux_clear_interrupts(struct apple_gmux_data *gmux_data)
>  	/* to clear interrupts write back current status */
>  	status = gmux_interrupt_get_status(gmux_data);
>  	gmux_write8(gmux_data, GMUX_PORT_INTERRUPT_STATUS, status);
> +	if (gmux_data->config->use_acpi_gmsp)
> +		gmux_call_acpi_gmsp(gmux_data, 0);
>  }

I think it would be clearer to check the gmux type directly here,
so that a casual reader understands that invoking the method is
necessary on MMIO-accessed GMUXes, but not any of the other types.
By contrast, with the use_acpi_gmsp one has to look up first which
of the gmux types sets this to true.

What happens if GMSP is not executed?  Needs to be documented in the
commit message and/or a code comment!

Thanks,

Lukas
