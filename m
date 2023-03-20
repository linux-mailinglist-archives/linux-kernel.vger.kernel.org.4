Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06106C1487
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 15:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbjCTORm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 10:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbjCTORg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 10:17:36 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9315927D67;
        Mon, 20 Mar 2023 07:17:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 774DFCE12B0;
        Mon, 20 Mar 2023 14:17:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F98C433A8;
        Mon, 20 Mar 2023 14:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679321849;
        bh=aKMxejypqYGtstTSZaALmz6QKeR6kRQMkXNt7PN5Rqo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HeeQW3bmMhNgQRTD1yzFc05O7cqd4QMqRZbOzM6RVy0l/OU6l/B2M098aPIYWHFnZ
         w1syANmqkE/2tE2lE3GWwohKchzVNNmDRN6FHgGitTW7i8i18rT96Ttr6/03jU9qtj
         /EJ5tt773bkfCEYA3i0Gx4DH7J88hIVkWG4C5RNOo1XExBGt2goYmuZitboZnMxBUb
         FFwx9fmYla8b2S6wwMIlYqg543d/D6dC5dSh8PhbP7/IczhB3OUxgL+tZ9U1VNG0GH
         hYtpngaP+u8NYfB2T8V2Q3yWI5wSOI950eHFR/8lVz3CZUypC1kCafMfeS81l2tUtw
         Xig94ETO/6ZPg==
Received: by mail-ua1-f50.google.com with SMTP id ay14so7979144uab.13;
        Mon, 20 Mar 2023 07:17:29 -0700 (PDT)
X-Gm-Message-State: AO0yUKUR/5UXYlUpWtSAvqm36VcEyBk/6BmDI0v2OSWTe0UWGlYKgWZ7
        Gid3ddDYhmr+u9UTON2s/m2B70h6uHf/R75Yfg==
X-Google-Smtp-Source: AK7set/6eiFW2xFlHjvRE53ibb1vDYufRHrv7hCBpS4QB9kFF8AO/fAfVdO8LHihe5D01sI28nuWjz4W3poi8n3cClc=
X-Received: by 2002:a1f:9ed3:0:b0:418:4529:a308 with SMTP id
 h202-20020a1f9ed3000000b004184529a308mr3939800vke.3.1679321848147; Mon, 20
 Mar 2023 07:17:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230317030501.1811905-1-anshuman.khandual@arm.com>
In-Reply-To: <20230317030501.1811905-1-anshuman.khandual@arm.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 20 Mar 2023 09:17:16 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKsnq0d-x3m3xQe8m0pnk_Jeh9J1oFBtPAn3LV8-MFH0w@mail.gmail.com>
Message-ID: <CAL_JsqKsnq0d-x3m3xQe8m0pnk_Jeh9J1oFBtPAn3LV8-MFH0w@mail.gmail.com>
Subject: Re: [PATCH 0/7] coresight: etm4x: Migrate AMBA devices to platform driver
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, scclevenger@os.amperecomputing.com,
        Frank Rowand <frowand.list@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 10:05=E2=80=AFPM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
> CoreSight ETM4x devices could be accessed either via MMIO (handled via
> amba_driver) or CPU system instructions (handled via platform driver). Bu=
t
> this has the following issues :
>
>   - Each new CPU comes up with its own PID and thus we need to keep on
>     adding the "known" PIDs to get it working with AMBA driver. While
>     the ETM4 architecture (and CoreSight architecture) defines way to
>     identify a device as ETM4. Thus older kernels  won't be able to
>     "discover" a newer CPU, unless we add the PIDs.

But v8.4 discourages MMIO access, so this problem will go away on its
own. Even if not, adding IDs to stable kernels is standard practice
whether it is PCI VID/PID, compatible string or AMBA PID.

>   - With ACPI, the ETM4x devices have the same HID to identify the device
>     irrespective of the mode of access. This creates a problem where two
>     different drivers (both AMBA based driver and platform driver) would
>     hook into the "HID" and could conflict. e.g., if AMBA driver gets
>     hold of a non-MMIO device, the probe fails. If we have single driver
>     hooked into the given "HID", we could handle them seamlessly,
>     irrespective of the mode of access.

Why are we changing DT for ACPI? Just always use the platform driver
for ACPI and leave DT systems alone.

>   - CoreSight is heavily dependent on the runtime power management. With
>     ACPI, amba_driver doesn't get us anywhere with handling the power
>     and thus one need to always turn the power ON to use them. Moving to
>     platform driver gives us the power management for free.

This sounds like an issue for any amba driver. If this is an issue,
solve it for everyone, not just work around it in one driver.

When someone puts another primecell device into an ACPI system, are we
going to go do the same one-off change in that driver too? (We kind of
already did with SBSA UART...)

Rob
