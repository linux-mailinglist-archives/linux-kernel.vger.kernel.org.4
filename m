Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24F771F333
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 21:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbjFATsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 15:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjFATsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 15:48:46 -0400
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8383184;
        Thu,  1 Jun 2023 12:48:45 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1b041cceb16so11143115ad.2;
        Thu, 01 Jun 2023 12:48:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685648925; x=1688240925;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jIvV0wZNClXbTeFKKUQvtDmnFEe+LAtKQ1KeK9o1Yds=;
        b=eCz9pV6g9w2DRT/Z5Te383UF3Vi5xuoCzBgKvojs6PUPeUQDNqaqc51S6sBKFZIswG
         N/QXOAGUJiAeqrcRUD0mtnHPG0l5Iq8iZZu1cT5fjgJHCmKgSFLy82mIHUtNJvpvSbkh
         GIkdpOfXuLlwZ50Ai65roZpAENcJD8lsB/S1I9Hlpb1puixVmY12Vsi7pYXrt8po3Y4P
         RrWWGbUVtombVHJ7tvhqgVzrIyBZHrti1lsaGAsegU+pkaZRmtFffXm3ri4zQJ77XR3C
         OnO1DH59NWPpG+1nJa1Wyluq+gv78M6AetgmEIMlJoiypv5EgnKnjb+Pa+27tE4+MZ3c
         1fMw==
X-Gm-Message-State: AC+VfDxanAWHCE5cm97nSVgTXd/J1FTHhrzgXCghpAhBvfD2pzCUKqoA
        oftJ2OGbO7QSEoWbY6MmJPg=
X-Google-Smtp-Source: ACHHUZ7Iwtz3jz01FcOvoBj0hs4t01IPS1TfcdJfY7bwsIfn7GoqjmozuA0FNYyJ2k9UviF0s2TKaw==
X-Received: by 2002:a17:902:ce8f:b0:1aa:d545:462e with SMTP id f15-20020a170902ce8f00b001aad545462emr472333plg.13.1685648924940;
        Thu, 01 Jun 2023 12:48:44 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id e3-20020a170902744300b001b0395c4002sm3845405plt.210.2023.06.01.12.48.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 12:48:44 -0700 (PDT)
Message-ID: <164576ab-4e68-ca5d-0c9e-d756588cdbb5@acm.org>
Date:   Thu, 1 Jun 2023 12:48:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5] scsi: core: Wait until device is fully resumed before
 doing rescan
Content-Language: en-US
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     dlemoal@kernel.org, bblock@linux.ibm.com, acelan.kao@canonical.com,
        linux-pm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230601155652.1157611-1-kai.heng.feng@canonical.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230601155652.1157611-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/23 08:56, Kai-Heng Feng wrote:
> During system resuming process, the resuming order is from top to down.
> Namely, the ATA host is resumed before disks connected to it.
> 
> When an EH is scheduled while ATA host is resumed and disk device is
> still suspended, the device_lock hold by scsi_rescan_device() is never
> released so the dpm_resume() of the disk is blocked forerver, therefore
> the system can never be resumed back.
> 
> That's because scsi_attach_vpd() is expecting the disk device is in
> operational state, as it doesn't work on suspended device.
> 
> To avoid such deadlock, wait until the scsi device is fully resumed,
> before continuing the rescan process.

Why doesn't scsi_attach_vpd() support runtime power management? Calling 
scsi_attach_vpd() should result in a call of sdev_runtime_resume(), 
isn't it?

Thanks,

Bart.

