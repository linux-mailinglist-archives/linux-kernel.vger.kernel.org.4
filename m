Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E086ED146
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 17:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbjDXP1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 11:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjDXP1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 11:27:13 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25B0107
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 08:27:11 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Q4ps71Hc2z9sS4;
        Mon, 24 Apr 2023 17:27:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1682350027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Tt+Y6RZe0zG2wcUcokq0BmxIDA6TLPrv0bGafz9ZRk=;
        b=ax9QB8v+MBZ09/fkr0Gtv/mTTeschHlTrgxNyJZLTrFpvdvcr0XiGWAmkoV5jNboBrFtvk
        ismmDYlkuhL67Z8R+LFKqH6YSxbX4+56V0mcq4xpwfHdiiKO35p4Cfdsv+JLj0dByeP+qv
        TlBv0c+08Ujf15zK20LFUiGoD04ZtfDu8q5+fmq5ubNyFCzk8rvypm8Ne1wWUPbQx5zUwK
        M09uZHXcQ5lWzRNPjXLoGJiFLxgIsvX4fnX+wR+NLU1YPYkmExQm2Cq16p8ibY0C52o+eu
        8F2bjF9yS3sAtK2VylxztJmklpdOa5fLkejwLOPFojm55F+PFe63L1lvMq/QfQ==
Message-ID: <ee66058d-0d2c-9665-d4ea-c07f9aca820f@mailbox.org>
Date:   Mon, 24 Apr 2023 17:27:05 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] drm/amdgpu: Mark contexts guilty for any reset type
To:     =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc:     pierre-eric.pelloux-prayer@amd.com,
        =?UTF-8?B?J01hcmVrIE9sxaHDoWsn?= <maraeo@gmail.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        "Tuikov, Luben" <Luben.Tuikov@amd.com>,
        dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
        alexander.deucher@amd.com
References: <20230424014324.218531-1-andrealmeid@igalia.com>
 <d7264c5a-29b4-0fb3-153b-673a8a73d635@amd.com>
 <717b333b-7af6-063e-d50d-bb2b3bbcecb4@igalia.com>
Content-Language: de-CH-frami, en-CA
From:   =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>
In-Reply-To: <717b333b-7af6-063e-d50d-bb2b3bbcecb4@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 44fd1fd5febec46d579
X-MBO-RS-META: bbd7r41xaxjj4czat5xnca4663bb86cm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/23 15:26, André Almeida wrote:
>>
>> Additional to that I currently didn't considered soft-recovered submissions as fatal and continue accepting submissions from that context, but already wanted to talk with Marek about that behavior.
>>
> 
> Interesting. I will try to test and validate this approach to see if the contexts keep working as expected on soft-resets.

FWIW, on this Thinkpad E595 with a Picasso APU, I've hit soft-resets (usually either in Firefox or gnome-shell) a number of times, and usually continued using the GNOME session for a few days without any issues.

(Interestingly, Firefox reacts to the soft-resets by falling back to software rendering, even when it's not guilty itself)


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

