Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19355E96E3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 01:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbiIYXVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 19:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbiIYXVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 19:21:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65739248F1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 16:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664148080;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sCD0xx2zMa4gS6Q6TKSN9kVDHDoO1KNdmd+17CQdIKI=;
        b=W96fRnxurw6tUDCPaR7fSuCMu2fhFpHRsAQjdVkBmdlXhNB1BhQQlXPLEhk21pS3hzotyq
        vVEs4tUE3dJ+dxjWQT6/kMPcTWAOo70QHrzr/xUgEnHvB3UkDxMozVT/Gn4n8AcHlWi01i
        X1ALIGuE5HmNW/pNrrEqZj/r3b+w2/Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-346-_NE_ZJrjOMeXaolZDVnXTw-1; Sun, 25 Sep 2022 19:21:16 -0400
X-MC-Unique: _NE_ZJrjOMeXaolZDVnXTw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6511A85A583;
        Sun, 25 Sep 2022 23:21:15 +0000 (UTC)
Received: from [10.64.54.126] (vpn2-54-126.bne.redhat.com [10.64.54.126])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B4A3140EBF3;
        Sun, 25 Sep 2022 23:21:11 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH] KVM: arm64: vgic: Remove duplicate check in
 update_affinity_collection()
To:     Marc Zyngier <maz@kernel.org>
Cc:     kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        will@kernel.org, eric.auger@redhat.com, yuzhe@nfschina.com,
        oliver.upton@linux.dev, shan.gavin@gmail.com,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexandru Elisei <Alexandru.Elisei@arm.com>
References: <20220923065447.323445-1-gshan@redhat.com>
 <87bkr5hto4.wl-maz@kernel.org>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <61dad836-2c4d-e462-3f52-1524db437629@redhat.com>
Date:   Mon, 26 Sep 2022 09:21:08 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <87bkr5hto4.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 9/24/22 9:56 PM, Marc Zyngier wrote:
> Side note: please make sure you always Cc all the KVM/arm64 reviewers
> when sending patches (now added).
> 

Sure. The reason, why I didn't run './scripts/get_maintainer.pl' to get
all reviewers, is the patch is super simple one :)

> On Fri, 23 Sep 2022 07:54:47 +0100,
> Gavin Shan <gshan@redhat.com> wrote:
>>
>> The ITS collection is guranteed to be !NULL when update_affinity_collection()
>> is called. So we needn't check ITE's collection with NULL because the
>> check has been included to the later one.
> 
> It took me a while to understand what you meant by this: the 'coll'
> parameter to update_affinity_collection() is never NULL, so comparing
> it with 'ite->collection' is enough to cover both the NULL case and
> the "another collection" case.
> 
> If you agree with this, I can directly fix the commit message when
> applying the patch.
> 

Yes, the commit message is accurate and correct. Please help to apply
your commit message directly :)

Thanks,
Gavin

