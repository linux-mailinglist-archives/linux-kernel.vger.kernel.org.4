Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEDD6BB991
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 17:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjCOQWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 12:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbjCOQWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 12:22:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B970184
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 09:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678897286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gLpXDCqdXOXJIgT6RZL1oqrUDc+znTju+CcMww0NbwY=;
        b=TJJ3jhXnVq23C9JF1JwXAXmvSi3uvDH7lvfrL7rNOLSotJB0jBWGQSefiYp1LKAKzOzsj8
        HcKHovPARpbMfbmlrhboCoxYpI7nXaDPICiw06OK3VSXOLNAFETSQES0mZkZ94/vCrRNzi
        ZY1d4/G/pMWJMcBrZCEt+tTk4qyF9s0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-yCHe-VHZNaiWm0wbhL5ojw-1; Wed, 15 Mar 2023 12:21:24 -0400
X-MC-Unique: yCHe-VHZNaiWm0wbhL5ojw-1
Received: by mail-wm1-f71.google.com with SMTP id o2-20020a05600c510200b003ed2c898324so2288397wms.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 09:21:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678897282;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gLpXDCqdXOXJIgT6RZL1oqrUDc+znTju+CcMww0NbwY=;
        b=lwAn5U8/JOT4w75zQPCd+RG/VFp8g/54XKxocA13jnzDRteO7MMB0JmCH//ZGej/37
         hN7y05uV9eAw0pUJWV5gKSYSGMoHbvkQCl6OezICAtDkR4TXznNEvvRYEaHG6wtC20GL
         OtMS1/DgBCJFaMZwXuSNJOsBjzBfcICribyQ1tJYBx5qabe5bNQ6d49BstZ0KDcadHKp
         c6330tBBmG8wm10/B7zIjhc48yoDmBCDJiygcyRI5yuXZWRVP8+5dAfNYLtI9jTAZ3Qg
         DdHUfJTC1u5vHpDr3CTWNjxaalueNuhnpi7CtxEtxu9LDFzqNNyfciBU6XgfPIIWWk2Y
         RlRw==
X-Gm-Message-State: AO0yUKWSgqVXJuHoSNoNIcoBPovdmfy+FuCDD4episAJ9IYO0nSAJKnN
        DE6+rQviQZ0e3lV60RPayZpI3Ar823M9Dn7TYZ18mTmgBu8oWYtNcE0UkQdJDu04rx3z1cOXAdE
        +/kkeaLRor5biZPabL1EXhToI
X-Received: by 2002:a05:600c:5493:b0:3ea:edc7:aa59 with SMTP id iv19-20020a05600c549300b003eaedc7aa59mr19083949wmb.32.1678897282738;
        Wed, 15 Mar 2023 09:21:22 -0700 (PDT)
X-Google-Smtp-Source: AK7set8l0FlMYlfB7z4wPq4zZjlG3lnnvvfGaqSVZmH/xQvlmt/IC3bGNvN60DywcA+W7MvhHiIeKA==
X-Received: by 2002:a05:600c:5493:b0:3ea:edc7:aa59 with SMTP id iv19-20020a05600c549300b003eaedc7aa59mr19083940wmb.32.1678897282523;
        Wed, 15 Mar 2023 09:21:22 -0700 (PDT)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id o19-20020a05600c059300b003eb68bb61c8sm2466199wmd.3.2023.03.15.09.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 09:21:21 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Tom Rix <trix@redhat.com>, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: Re: [PATCH] sched/topology: set varaiables
 sched_energy_mutex,update storage-class-specifier to static
In-Reply-To: <20230314144818.1453523-1-trix@redhat.com>
References: <20230314144818.1453523-1-trix@redhat.com>
Date:   Wed, 15 Mar 2023 16:21:19 +0000
Message-ID: <xhsmhfsa6m1ds.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/23 10:48, Tom Rix wrote:
> smatch reports
> kernel/sched/topology.c:212:1: warning:
>   symbol 'sched_energy_mutex' was not declared. Should it be static?
> kernel/sched/topology.c:213:6: warning:
>   symbol 'sched_energy_update' was not declared. Should it be static?
>
> These variables are only used in topology.c, so should be static
>
> Signed-off-by: Tom Rix <trix@redhat.com>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

