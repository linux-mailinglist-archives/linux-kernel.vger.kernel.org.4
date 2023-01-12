Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6639666DF9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 10:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235024AbjALJYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 04:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjALJXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 04:23:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A1D58FAB;
        Thu, 12 Jan 2023 01:13:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5416EB81DE8;
        Thu, 12 Jan 2023 09:13:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F4CC433F2;
        Thu, 12 Jan 2023 09:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673514793;
        bh=kEGTvDm5segAcaadzq0wJ5MfNW2R7JZZKdchDCKJD0E=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=e6PtrDaTa+SrVnqR0EL9ZA1/+axqXM3X5ItynF6qLmzEgYLuMdC8iQZq9B6bun8AU
         aUGczTnlCC/jSO8DenY7D2DZKCoBFjA9IpO5d2jMeUarSi9mNDPOgaTcfxODkdP9dH
         4T0FkjXaO8jJrFUVp6I/SttzFIxR2qdhRqJ4FsZEzuOr0K6ghtBAs1WnrR5YRPKm02
         JE5A/6cVFCv7+2UqZ79O/EbVgpGq7XoZCU7gYoj3VdojGYXAkslFxryJ6PAoQjdfTz
         8FJ5NMfi4yFPcsnkJ1OmGYcxpwU4/FeR93AcEJ8Nq3Wty9URzwBicsXNyrZiGMcqa5
         j6KPiO3f+5zdg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc:     Baochen Qiang <quic_bqiang@quicinc.com>,
        manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: [PATCH] bus: mhi: host: Change the log levels for SYS_ERR event
References: <20230104021445.47484-1-quic_bqiang@quicinc.com>
        <CAOCk7NpGBD-2nHFBE3a4WxNb4XPhEV3uoCDz1J9ArbaOE7Vscg@mail.gmail.com>
Date:   Thu, 12 Jan 2023 11:13:09 +0200
In-Reply-To: <CAOCk7NpGBD-2nHFBE3a4WxNb4XPhEV3uoCDz1J9ArbaOE7Vscg@mail.gmail.com>
        (Jeffrey Hugo's message of "Tue, 3 Jan 2023 19:41:44 -0700")
Message-ID: <87fscgdska.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jeffrey Hugo <jeffrey.l.hugo@gmail.com> writes:

> Why was this not sent to the MHI mailing list?
>
> On Tue, Jan 3, 2023 at 7:19 PM Baochen Qiang <quic_bqiang@quicinc.com> wrote:
>>
>> Currently no log printed when SYS_ERR happens, this makes
>> debug quite hard, so change log level to make it noisy.
>
> You are going to need to explain this more.
> There are two drivers in the upstream kernel that are MHI clients -
> pci_generic and ath11k.
> I'm assuming that you care about ath11k because you included that mail list.
> In ath11k_mhi_op_status_cb() I see a warning message printed when the
> syserr callback is triggered.
> I see something similar in pci_generic.
>
> Looks like a log is printed when SYS_ERR happens in all possible
> scenarios, so I don't understand the point of this change.
> Particularly given that dev_dbg messages can be trivially enabled.

Also the error messages are not very informative, especially if there
are three identical messages it's hard to track down which code path is
triggering them. If these are changed to error messages, I would prefer
to improve them as well.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
