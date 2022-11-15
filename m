Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8297962A066
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 18:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiKORb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 12:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbiKORbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 12:31:18 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6102D742
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 09:31:18 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id h14so13922028pjv.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 09:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3WYn35ypiR0kerP/5Orq6kPONHyF9mh27erQY6fQAE4=;
        b=IUVLb8ZQmTueToHsuEi7NSQpkpu8nY5pfPP+vnyQSjTvwdPhz/txYiuL5uFZKeszOM
         vfwPBaBGRNi4/7g0sINlx1k/NZk4schg1XlREBlGHvYwUD0OPGHvKItc95H64YaWRlMQ
         XCxrVaPmzOMVOlihaiv18J+3i3NvvbFVMdxi6f5mjyq1eMMQWdqXnvbqi4+UVtsfNjEb
         3Fx+s4hf9rQOdq0F03BQWYBvVbR+mSUEkfsmC8wUlJ59MCg6dsJftNIWxspi4XCb2c2T
         iciBvGaywJZNa6yly+4iPki+agVoQ+J/lBazkOcuEI65u6leR/8YxDPe12M4idY3yUKW
         ysdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3WYn35ypiR0kerP/5Orq6kPONHyF9mh27erQY6fQAE4=;
        b=Y2HdczkfglTFPdr9CGIYNRjJhlCsm+HnkTwYshlXuRJ3fC4X4cdNLXfAp3nkv3liYn
         EupkjPOYEjcFMxm13zNodnGcOZOVrb4fXNaen8I1jatz166W7wUEos/uzUsU+HaP4vw4
         SUljXeD8drIbxrxngt2GN7HW0a3z6Rh7zUZJ73WlDQmzDZMsKGJVEDLJdmbEhLhCWtzr
         vGIPbVIx1zUbfvlMKC+8+mfMc9QlS1KeTQGOgW39IepCg2N1XNKX77uQINK8RbLE1CjI
         Vg/UvI1HdfWSceSFJurvk9jyZ6Os0tTetD1IZPy9sMbFXCtbD52PZMTzSGdbFaf1Xmgr
         EdjA==
X-Gm-Message-State: ANoB5pnS5DlPBkGV94xE5gJ4C63k2nNGiMnFq8HK32nspWrbqpJSh8mX
        MLj+pgiXUKhwVuc2zRsBaBfXzg==
X-Google-Smtp-Source: AA0mqf6RfEQA0zCTH7tpFO2iXiilhuIFMN/mA/lK9eAs6iWb1y/ppTGeQDM2p7PWExIbLV+fBvhwvA==
X-Received: by 2002:a17:90a:b88d:b0:218:47f1:b473 with SMTP id o13-20020a17090ab88d00b0021847f1b473mr1533366pjr.140.1668533477492;
        Tue, 15 Nov 2022 09:31:17 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id f14-20020a170902ce8e00b00186b6bb2f48sm10271427plg.129.2022.11.15.09.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 09:31:17 -0800 (PST)
Date:   Tue, 15 Nov 2022 17:31:13 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     guo.ziliang@zte.com.cn
Cc:     pbonzini@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-next] KVM: replace DEFINE_SIMPLE_ATTRIBUTE with
 DEFINE_DEBUGFS_ATTRIBUTE
Message-ID: <Y3PM4euxrCFhZnCc@google.com>
References: <202211150858513761518@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202211150858513761518@zte.com.cn>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022, guo.ziliang@zte.com.cn wrote:
> From: guo ziliang <guo.ziliang@zte.com.cn>
> Fix the following coccicheck warning:
> /virt/kvm/kvm_main.c: 3849: 0-23: WARNING: vcpu_get_pid_fops
> should be defined with DEFINE_DEBUGFS_ATTRIBUTE
> 
> Signed-off-by: guo ziliang <guo.ziliang@zte.com.cn>
> ---
> virt/kvm/kvm_main.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 2719e10..6e58aec 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -3846,7 +3846,7 @@ static int vcpu_get_pid(void *data, u64 *val)
> return 0;
> }
> 
> -DEFINE_SIMPLE_ATTRIBUTE(vcpu_get_pid_fops, vcpu_get_pid, NULL, "%llu\n");
> ++DEFINE_DEBUGFS_ATTRIBUTE(vcpu_get_pid_fops, vcpu_get_pid, NULL, "%llu\n");

NAK, third time is not a charm.

https://lore.kernel.org/all/20221101072506.7307-1-liubo03@inspur.com
https://lore.kernel.org/all/20220815031228.64126-1-ye.xingchen@zte.com.cn
