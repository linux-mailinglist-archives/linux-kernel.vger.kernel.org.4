Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97BE5EE3F8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 20:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234698AbiI1SLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 14:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbiI1SK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 14:10:57 -0400
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1CF8A1D65;
        Wed, 28 Sep 2022 11:10:56 -0700 (PDT)
Received: by mail-pj1-f54.google.com with SMTP id l9-20020a17090a4d4900b00205e295400eso2371687pjh.4;
        Wed, 28 Sep 2022 11:10:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=GKDnwlvt98AzYvx8t1Z5mBjBPM9OSikHPq+0SvL9Y6w=;
        b=BqTMUUhvd8QcTzNSgoQK8zbz/nbzLRBX6JUblecqyrLJ9REVfXjV0piTiBAgkivKkV
         YqHMlCDHnbe6VlOxOxy5YmAnIawkP9Yxe62A2oIzHn8nfyGlgdRm255mQ62hTzbs0OSJ
         VcOkyEnfD2jkeVX9DYaaRCBMvCeIxziqS34nzPndrPTOrHIkldTF7XYcp2ei7Wv2taST
         pcg0Aabsy7WLLorXh5egq/aZvfuF6MGv2e7IB75N1DM/6beSodOIJpo5UzDQgD7EgkCR
         ADZLU17n5Evisrpprkf1FIOaZ7YMMVwferJyhSTk8s6UygGmhDP81GJDPRc21B9KsP9j
         Eicw==
X-Gm-Message-State: ACrzQf1orNs+KuorM9RIFth8PsjhUxepfVoxLHq+eidqOxwI3wTNLoZZ
        uKMuKhpdHUFItoODviL8V5M=
X-Google-Smtp-Source: AMsMyM6IxpfaBJs42tePmX0Cj6OVnmn2lb9A/fUs5CG7m7PAuLn3yEE2tGgbRAOQDk0DKNCAQZzakQ==
X-Received: by 2002:a17:902:ea12:b0:178:8e76:c781 with SMTP id s18-20020a170902ea1200b001788e76c781mr1044864plg.136.1664388656275;
        Wed, 28 Sep 2022 11:10:56 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:4cba:f1a9:6ef8:3759? ([2620:15c:211:201:4cba:f1a9:6ef8:3759])
        by smtp.gmail.com with ESMTPSA id i132-20020a62878a000000b0053651308a1csm4352316pfe.195.2022.09.28.11.10.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 11:10:55 -0700 (PDT)
Message-ID: <26566e80-bf67-8c9f-9aac-b636cfaf473c@acm.org>
Date:   Wed, 28 Sep 2022 11:10:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v15 07/13] zonefs: allow non power of 2 zoned devices
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, snitzer@kernel.org,
        axboe@kernel.dk, agk@redhat.com, hch@lst.de,
        damien.lemoal@opensource.wdc.com
Cc:     jaegeuk@kernel.org, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, hare@suse.de,
        matias.bjorling@wdc.com, Johannes.Thumshirn@wdc.com,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        pankydev8@gmail.com, dm-devel@redhat.com,
        Luis Chamberlain <mcgrof@kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>
References: <20220923173618.6899-1-p.raghav@samsung.com>
 <CGME20220923173627eucas1p2f134d9cb331e4a8f0fca8431eeb0f0b0@eucas1p2.samsung.com>
 <20220923173618.6899-8-p.raghav@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220923173618.6899-8-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/22 10:36, Pankaj Raghav wrote:
> The zone size shift variable is useful only if the zone sizes are known
> to be power of 2. Remove that variable and use generic helpers from
> block layer to calculate zone index in zonefs.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


