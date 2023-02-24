Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552E86A2211
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 20:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjBXTHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 14:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjBXTHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 14:07:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7743771B
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 11:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677265573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TO32MmHRC5X6hVdeytKpEjQuFgiB4c62vSXkbsV3be0=;
        b=JplskUSuU/ceWMzpto0lgV23LuWdzQG7l41s2lWizg6hr3mZQJgmBbZD1uNJzrxVRYRb2y
        h6wrwoCnxmt3P21SuYX/Cm01bAeKGAd+hYF7jW60Jp0qkkSgXxzBoVLERhz62KTqF8O7FZ
        nuBi6A47ScqJ3CbpP7miiiQ+EKsfS+Q=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-357-U7kBTsPGOQmlX6i9cjlAeA-1; Fri, 24 Feb 2023 14:06:11 -0500
X-MC-Unique: U7kBTsPGOQmlX6i9cjlAeA-1
Received: by mail-io1-f71.google.com with SMTP id i3-20020a0566022c8300b0073a6a9f8f45so8973346iow.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 11:06:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TO32MmHRC5X6hVdeytKpEjQuFgiB4c62vSXkbsV3be0=;
        b=4EaFFaFVLa8eQaUPMT/VpKIenz3zFR7ilnX6FjX8JdDobCnOBgK14A2yBTOZvRHjym
         +6P1W3b33FKeM5T4Ofxrm7G24olgiYdiqyXwGzZ/e0SHtuboCnqlc4cKHA0yl8LsG5vz
         PXrF7NpC4oaw4Xkyx6tMcAyPPg9WukO0raqia8IQkEEX82d84r2LonNUjUoMinF2jWXm
         2rWn9+VxLmyBcvD0vaPLQ5um4dYMM9y06d/6VLqXBFGMBZ6GRruqQOHN2/L6vyI0tgDs
         vZjmzQAhaCbJIHdITgTGOsTFQCS3jj7S2HlDJ5ooAseFf4AlMIoLd8f75mnyA3BNgmLm
         nVIA==
X-Gm-Message-State: AO0yUKWJOOSsx/tA2HcWFljbtPrIwnX/7ILc/BdnNt0Jb66shoxBJjc3
        mOCC6eT92wAPD4fBqgksnsKEtV5gk95N2AcOKmV0IiYwoVAi/UjKRz4b3SGQWnV2lLv8pOUoUhR
        cyKKrWaoaJW+9LC5qzC53QRpj
X-Received: by 2002:a05:6602:200f:b0:74c:bc54:def6 with SMTP id y15-20020a056602200f00b0074cbc54def6mr790438iod.16.1677265571053;
        Fri, 24 Feb 2023 11:06:11 -0800 (PST)
X-Google-Smtp-Source: AK7set9/Pv5CyL/4mD4A9Y4Q/LVOJsbK7o9jmpBuvUza9YaJUBhEetobrRKdqPedvvHaEaB9J1UmPg==
X-Received: by 2002:a05:6602:200f:b0:74c:bc54:def6 with SMTP id y15-20020a056602200f00b0074cbc54def6mr790426iod.16.1677265570885;
        Fri, 24 Feb 2023 11:06:10 -0800 (PST)
Received: from x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id l5-20020a6b7b05000000b0073f8a470bacsm24221iop.16.2023.02.24.11.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 11:06:09 -0800 (PST)
Date:   Fri, 24 Feb 2023 14:06:07 -0500
From:   Brian Masney <bmasney@redhat.com>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 0/6] Add basic Minidump kernel driver support
Message-ID: <Y/kKn9tnvSQ2Pacn@x1>
References: <1676978713-7394-1-git-send-email-quic_mojha@quicinc.com>
 <Y/deHzijzvuvCJ2M@x1>
 <47542dbb-8cf3-6eae-a38e-910d38bd960b@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47542dbb-8cf3-6eae-a38e-910d38bd960b@quicinc.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mukesh,

On Fri, Feb 24, 2023 at 04:10:42PM +0530, Mukesh Ojha wrote:
> On 2/23/2023 6:07 PM, Brian Masney wrote:
> > I'd like to test this series plus your series that sets the multiple
> > download modes.
> 
> Sure, you are welcome, but for that you need a device running with Qualcomm
> SoC and if it has a upstream support.

I will be testing this series on a sa8540p (QDrive3 Automotive
Development Board), which has the sc8280xp SoC with good upstream
support. This is also the same board that I have a reliable way to
make the board crash due to a known firmware bug.

> Also, testing of this patch needs some minimal out of tree patches and
> i can help you with that.

Yup, that's fine. Hopefully we can also work to get those dependencies
merged upstream as well.

Brian

