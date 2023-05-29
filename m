Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84040714662
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 10:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbjE2Ii5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 04:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjE2Iiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 04:38:55 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56633A4;
        Mon, 29 May 2023 01:38:54 -0700 (PDT)
Received: from g550jk.localnet (217-149-172-244.nat.highway.telekom.at [217.149.172.244])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 95F33C6A55;
        Mon, 29 May 2023 08:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1685349502; bh=uOnCZnZI6C1aOMtX/ZNJQr6sz8PO+7+LG0+1e7bYZjk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=p4ZV1g9EgMR07boeQSo2YgIWBm/O7DoSiUrF6CdueTH+ShW5PvLatDbYUFK9Dt0r1
         jGjvXg+uwU4Zkbnw8/tH2WizWmWH7lC6EWXjEBe89CNq92qA+1S32w9IhfYGYuFQon
         eYGr4cC4JsoQD4mATCeg8Ol/NopoMtfVxWbGiY/A=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Brian Masney <masneyb@onstation.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] soc: qcom: ocmem: Add OCMEM hardware version print
Date:   Mon, 29 May 2023 10:38:20 +0200
Message-ID: <2680722.mvXUDI8C0e@z3ntu.xyz>
In-Reply-To: <cac92fae-310f-79b1-7204-ac9deb2c3319@linaro.org>
References: <20230509-ocmem-hwver-v2-1-8c8793a07dfc@z3ntu.xyz>
 <cac92fae-310f-79b1-7204-ac9deb2c3319@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Freitag, 26. Mai 2023 21:39:44 CEST Konrad Dybcio wrote:
> On 23.05.2023 22:32, Luca Weiss wrote:
> > It might be useful to know what hardware version of the OCMEM block the
> > SoC contains. Add a debug print for that.
> > 
> > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > ---
> > This patch is depends on [0] but could also be applied in the other
> > order, if conflicts are resolved.
> > 
> > [0]
> > https://lore.kernel.org/linux-arm-msm/20230506-msm8226-ocmem-v1-1-3e24e27
> > 24f01@z3ntu.xyz/ ---
> > Changes in v2:
> > - Use FIELD_GET macros for getting correct bits from register (take
> > 
> >   wording from mdp5: major, minor, step which hopefully is sort of
> >   accurate)
> 
> Qualcomm uses that (or that-ish) nomenclature for many hw blocks, so
> it's likely spot on.
> 
> > - Link to v1:
> > https://lore.kernel.org/r/20230509-ocmem-hwver-v1-1-b83ece3f2168@z3ntu.xy
> > z ---
> > 
> >  drivers/soc/qcom/ocmem.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/drivers/soc/qcom/ocmem.c b/drivers/soc/qcom/ocmem.c
> > index c3e78411c637..9f7c3348cbb9 100644
> > --- a/drivers/soc/qcom/ocmem.c
> > +++ b/drivers/soc/qcom/ocmem.c
> > @@ -76,6 +76,10 @@ struct ocmem {
> > 
> >  #define OCMEM_REG_GFX_MPU_START			0x00001004
> >  #define OCMEM_REG_GFX_MPU_END			0x00001008
> > 
> > +#define OCMEM_HW_VERSION_MAJOR(val)		FIELD_GET(GENMASK(31, 28), val)
> > +#define OCMEM_HW_VERSION_MINOR(val)		FIELD_GET(GENMASK(27, 16), val)
> > +#define OCMEM_HW_VERSION_STEP(val)		FIELD_GET(GENMASK(15, 0), val)
> > +
> > 
> >  #define OCMEM_HW_PROFILE_NUM_PORTS(val)		FIELD_GET(0x0000000f, (val))
> >  #define OCMEM_HW_PROFILE_NUM_MACROS(val)	FIELD_GET(0x00003f00, (val))
> > 
> > @@ -355,6 +359,11 @@ static int ocmem_dev_probe(struct platform_device
> > *pdev)> 
> >  		}
> >  	
> >  	}
> > 
> > +	reg = ocmem_read(ocmem, OCMEM_REG_HW_VERSION);
> > +	dev_dbg(dev, "OCMEM hardware version: %ld.%ld.%ld\n",
> 
> reg is an unsigned long (u32), this should probably be %u

I can make it %lu, just %u gives me this warning

drivers/soc/qcom/ocmem.c:363:22: warning: format '%u' expects argument of type 'unsigned int', but argument 6 has type 'long unsigned int' [-Wformat=]
  363 |         dev_dbg(dev, "OCMEM hardware version: %u.%u.%u\n",
      |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Will send a v3 with that.

> 
> > +		OCMEM_HW_VERSION_MAJOR(reg), OCMEM_HW_VERSION_MINOR(reg),
> > +		OCMEM_HW_VERSION_STEP(reg));
> 
> Nit: one per line would make this the tiniest bit easier to read

ack

Regards
Luca

> 
> Konrad
> 
> > +
> > 
> >  	reg = ocmem_read(ocmem, OCMEM_REG_HW_PROFILE);
> >  	ocmem->num_ports = OCMEM_HW_PROFILE_NUM_PORTS(reg);
> >  	ocmem->num_macros = OCMEM_HW_PROFILE_NUM_MACROS(reg);
> > 
> > ---
> > base-commit: 8705151771af822ac794b44504cd72eebc423499
> > change-id: 20230509-ocmem-hwver-99bcb33b028b
> > 
> > Best regards,




