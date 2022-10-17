Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060B1600F24
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 14:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiJQMYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 08:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiJQMXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 08:23:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D869A12755
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 05:23:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 264CA218B0;
        Mon, 17 Oct 2022 12:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666009415; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ch0lcDKHBLmzGMbIyCzPneAQ4BwpLTCHPCHZaVD3tlg=;
        b=bGRcT684pGX3Ue4tFZ9X1+UduV3q5Gf2kV+yfUg7i/Ep8cNuNr30XOn4CQHAx5bDcPRI7l
        qUtQAn2hN1vNeDqZO92eaGE/2rNjJCsDnVR6JKY9f4HFfwec7X8R6sMUUID7mqeukkjPGt
        OuM4LPXtTFa2a5tVAzwyuSeSqyTfqx0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666009415;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ch0lcDKHBLmzGMbIyCzPneAQ4BwpLTCHPCHZaVD3tlg=;
        b=ZSfKP3QaOFzVuK52JDLVOx6/ZwqH6uzKlytPp/izWrzNAuqjuC0fImhNL4wPh2z1ydONGI
        t82yvTq0rAfS9CBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F180613398;
        Mon, 17 Oct 2022 12:23:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AgLAOUZJTWMRMQAAMHmgww
        (envelope-from <mliska@suse.cz>); Mon, 17 Oct 2022 12:23:34 +0000
Message-ID: <a55cb545-30d8-c035-ec23-4e94c132d7ba@suse.cz>
Date:   Mon, 17 Oct 2022 14:23:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] gcov: support GCC 12.1 and newer compilers
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        'Andrew Morton' <akpm@linux-foundation.org>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <624bda92-f307-30e9-9aaa-8cc678b2dfb2@suse.cz>
 <581f6037-ff43-4f91-cabf-d9aa0d72bbe6@linux.ibm.com>
 <20221016174033.d33a998b4c91b7d18b3dc310@linux-foundation.org>
 <9b724e2af2d048c3a7f7f20ae0942ab6@AcuMS.aculab.com>
From:   =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
In-Reply-To: <9b724e2af2d048c3a7f7f20ae0942ab6@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/22 13:38, David Laight wrote:
> From: Andrew Morton
>> Sent: 17 October 2022 01:41
> ..
>> The changelog doesn't tell us what the user-visible effects of this are
>> (please, it should do so), but it sounds to me like those effects are
>> "gcov is utterly busted".
>>
>> So I'll add a cc:stable to this, so that people can use new gcc
>> versions to build older kernels.
> 
> I can't help wondering what happens if you link a binary
> compiled with an old gcc with one build with a new gcc?

It should be fine as the code emits each .gcda file with version that
comes from the compilation phase:

	pos += store_gcov_u32(buffer, pos, info->version);

> 
> This could easily happen with out of tree loadable modules.

Sure.

> Or just linking an old .a file into a userspace binary.
> 
> Now maybe the gcov data isn't used (I've not looked up what
> it is for) but is sounds like something whose format should
> be set in stone?

No, I've doing some changes to the format based on new challenges we face.

Cheers,
Martin

> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)

