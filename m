Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2806A08B6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 13:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbjBWMiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 07:38:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbjBWMiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 07:38:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D3BB467
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 04:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677155876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o5faige4boHy1KDnDJFUMGzlyi7Wgdd7JL40G0EvBo0=;
        b=DAd69z/mYzo+WhTe+QrdMa5w37mfk94GO5CzaCRSOEbhF+nhiqNXPbPhC/TArBDxe5+B9+
        liEk1vMkKXZ/PdYUSmxQYw0OoYAvhg33TEnNA7VnKGnwqpzN2PcPOSVg+edfytRdxDJTkD
        bSzjTpjE7EMvgAL9ZDqsoUIkwDr3Q1o=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-382-HzEOVey7O9KTh4LoYkX_Ew-1; Thu, 23 Feb 2023 07:37:55 -0500
X-MC-Unique: HzEOVey7O9KTh4LoYkX_Ew-1
Received: by mail-io1-f70.google.com with SMTP id z6-20020a056602080600b007407df88db0so6278572iow.23
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 04:37:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o5faige4boHy1KDnDJFUMGzlyi7Wgdd7JL40G0EvBo0=;
        b=vjEcXRCyyV0UQAEO7XYBhWLlednnz67QXwjaqq/ZnnR/9l+v2IJ1blit421NP/z7rM
         yEHumCCOQjo3WtC5WznA4+WEmhDuJHwPyYIqtRvRm5iZdnSh8gHyIw0YIywOkcx6sxkn
         yYsz7p2DsxfOggXgKeRySy+ODIe7Q0EbTJgAWsu2g+eqTz0EGS1x5CJ075tgI06a5wh8
         VOAscjTVQOIyaP8RwJK4dwUhXvaesIEHetMD4CICkMqt90ljgyYMNp2XkHGJglUejZgt
         xMNyYWbHvyK7I5TI+mydKF8jbJa8xSh+Y2x8WDxuW+Nzm+902er/F8SvUjkOzu/Ou2nz
         ZuKQ==
X-Gm-Message-State: AO0yUKWUNEYxyrKNCJ7Lk4clpWBTT3yybGfFgLqaX0sRaxxygOS0KE0K
        K4eBAfJZMxXEwIYdjCW13eOcE3zzgfdksLX6azMSjbHrl4///ZG42N1YZRrJOTLLV+tPDhS0ZYu
        wHnig3RWBhq83sD50+nsomROa
X-Received: by 2002:a05:6e02:1445:b0:316:e54a:828f with SMTP id p5-20020a056e02144500b00316e54a828fmr6493874ilo.6.1677155874528;
        Thu, 23 Feb 2023 04:37:54 -0800 (PST)
X-Google-Smtp-Source: AK7set/6AWA4CAuXGZNmzPhHzcrBdzMdBpWOTtYJucrF1Qv97MIIPEiFDxaTnG32VB1VQ2w0xUjrzA==
X-Received: by 2002:a05:6e02:1445:b0:316:e54a:828f with SMTP id p5-20020a056e02144500b00316e54a828fmr6493856ilo.6.1677155874289;
        Thu, 23 Feb 2023 04:37:54 -0800 (PST)
Received: from x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id y22-20020a02bb16000000b0039e89ea68f9sm1759062jan.135.2023.02.23.04.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 04:37:53 -0800 (PST)
Date:   Thu, 23 Feb 2023 07:37:51 -0500
From:   Brian Masney <bmasney@redhat.com>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 0/6] Add basic Minidump kernel driver support
Message-ID: <Y/deHzijzvuvCJ2M@x1>
References: <1676978713-7394-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1676978713-7394-1-git-send-email-quic_mojha@quicinc.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 04:55:07PM +0530, Mukesh Ojha wrote:
> Minidump is a best effort mechanism to collect useful and predefined data
> for first level of debugging on end user devices running on Qualcomm SoCs.
> It is built on the premise that System on Chip (SoC) or subsystem part of
> SoC crashes, due to a range of hardware and software bugs. Hence, the
> ability to collect accurate data is only a best-effort. The data collected
> could be invalid or corrupted, data collection itself could fail, and so on.
> 
> Qualcomm devices in engineering mode provides a mechanism for generating
> full system ramdumps for post mortem debugging. But in some cases it's
> however not feasible to capture the entire content of RAM. The minidump
> mechanism provides the means for selecting which snippets should be
> included in the ramdump.
> 
> The core of minidump feature is part of Qualcomm's boot firmware code.
> It initializes shared memory (SMEM), which is a part of DDR and
> allocates a small section of SMEM to minidump table i.e also called
> global table of content (G-ToC). Each subsystem (APSS, ADSP, ...) has
> their own table of segments to be included in the minidump and all get
> their reference from G-ToC. Each segment/region has some details like
> name, physical address and it's size etc. and it could be anywhere
> scattered in the DDR.
> 
> Existing upstream Qualcomm remoteproc driver[1] already supports minidump
> feature for remoteproc instances like ADSP, MODEM, ... where predefined
> selective segments of subsystem region can be dumped as part of
> coredump collection which generates smaller size artifacts compared to
> complete coredump of subsystem on crash.
> 
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/remoteproc/qcom_common.c#n142
> 
> In addition to managing and querying the APSS minidump description,
> the Linux driver maintains a ELF header in a segment. This segment
> gets updated with section/program header whenever a new entry gets
> registered.

I'd like to test this series plus your series that sets the multiple
download modes. Can you include documentation about how to actually use
this new feature? Also the information that you provided above is really
useful. I think that should also go in the documentation file as well.

I already have a reliable way to make a board go BOOM and go into
ramdump mode.

Brian

