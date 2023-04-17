Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD306E5085
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 21:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjDQTC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 15:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjDQTC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 15:02:26 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E01E62
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 12:02:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 08A5B1F85D;
        Mon, 17 Apr 2023 19:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681758143; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Bm/TkpcMy6cuYGFixPMtHN6GQvyYrnWfVkOFEnqjaw=;
        b=VMALOtZopBgD/6l2GDTO7VzUHOBAFNMokUNAQT3o2i/7q+iRcJvNU1/wGkUHrBSH+vsG1c
        g3oX0FMqF8FQ4nmXN/26AQcAN/vKgHXLL9w9T/gYyXpnk/LSOKOqJld+dq7Yv8s10l01DZ
        S0utMIsut+u6oc9PfaTU9jQ3jswZ1F4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681758143;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Bm/TkpcMy6cuYGFixPMtHN6GQvyYrnWfVkOFEnqjaw=;
        b=GMsCwVu6HWh2dPz+S/L4pxzYt++4V7dmJTdQEF2RC7ffeASZHg5UUFOap5IwuJOyI7XJTU
        WfNRFCPcGSp4TfCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E012013319;
        Mon, 17 Apr 2023 19:02:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rB4YNr6XPWQxIwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 17 Apr 2023 19:02:22 +0000
Message-ID: <17bbab58-3cde-e980-bdeb-b9de65848b2e@suse.cz>
Date:   Mon, 17 Apr 2023 21:02:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 2/2] mm/slab: break up RCU readers on
 SLAB_TYPESAFE_BY_RCU example code
Content-Language: en-US
To:     SeongJae Park <sj@kernel.org>, Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, paulmck@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230417190129.1454-1-sj@kernel.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230417190129.1454-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/17/23 21:01, SeongJae Park wrote:
> On Mon, 17 Apr 2023 18:53:24 +0100 Matthew Wilcox <willy@infradead.org> wrote:
> 
>> On Mon, Apr 17, 2023 at 05:26:57PM +0000, SeongJae Park wrote:
>> > Hi Vlastimil,
>> > 
>> > On Mon, 17 Apr 2023 13:05:40 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:
>> > 
>> > > On 4/15/23 05:31, SeongJae Park wrote:
>> > > > The SLAB_TYPESAFE_BY_RCU example code snippet is having not tiny RCU
>> > > 
>> > > Since "tiny RCU" means something quite specific in the RCU world, it can be
>> > > confusing to read it in this sense. We could say e.g. "... snippet uses a
>> > > single RCU read-side critical section for retries"?
>> > 
>> > Looks much better, thank you for this suggestion!
>> > 
>> > > 
>> > > > read-side critical section.  'Documentation/RCU/rculist_nulls.rst' has
>> > > > similar example code snippet, and commit da82af04352b ("doc: Update and
>> > > > wordsmith rculist_nulls.rst") has broken it.
>> > > 
>> > > "has broken it" has quite different meaning than "has broken it up" :) I
>> > > guess we could just add the "up", unless someone has an even better wording.
>> > 
>> > Good point, thank you for your suggestion!
>> > 
>> > I will apply above suggestion on the next spin.
>> 
>> For the last one, perhaps changing the tense would have more clarity:
>> 
>> similar example code snippet, and commit da82af04352b ("doc: Update and
>> wordsmith rculist_nulls.rst") broke it up.
> 
> Thank you for this suggestion, Matthew!  Will send a new version.

It's ok, I can just use that when picking the patches up without a new resend.

> Thanks,
> SJ

