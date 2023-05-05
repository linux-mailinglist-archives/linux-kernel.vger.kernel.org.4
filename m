Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B736F7C62
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 07:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjEEF2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 01:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjEEF2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 01:28:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0E2A27E;
        Thu,  4 May 2023 22:28:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9530722C68;
        Fri,  5 May 2023 05:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683264499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zs92ZqlzwMgAJ9tbeR2IGrgHgQIB/HuXhxphZxkLhww=;
        b=kfCOS8ZfTctZ10pt9ywYJujUk4m8iIAHnIuLnwZlRNzaIeifzU+quGssJWSZeDfbid73a1
        7TjhxoRujgyIz01QoDTI9Zf8qMxbI04LAj1OFRWsZNSKN1uAEu53zPExWTiCjUPbxHVvvu
        LHPntCLIbWQoWXUMZxvBSn98JLbyeWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683264499;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zs92ZqlzwMgAJ9tbeR2IGrgHgQIB/HuXhxphZxkLhww=;
        b=JauynF/hOwzkAN4LGpnWILY0Qx2wVOqsDLhchgieDu8mvLg+FyrqwYK15IDAIitM5M1EUO
        GkCWqYAUtoiNQjBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B3EFF13358;
        Fri,  5 May 2023 05:28:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QhaNKfKTVGTdaQAAMHmgww
        (envelope-from <hare@suse.de>); Fri, 05 May 2023 05:28:18 +0000
Message-ID: <d6a6b309-285a-16ff-6563-1b21380b3a85@suse.de>
Date:   Fri, 5 May 2023 07:28:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [RFC PATCH 00/11] Rust null block driver
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Andreas Hindborg <nmi@metaspace.dk>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        lsf-pc@lists.linux-foundation.org, rust-for-linux@vger.kernel.org,
        linux-block@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        open list <linux-kernel@vger.kernel.org>, gost.dev@samsung.com
References: <20230503090708.2524310-1-nmi@metaspace.dk>
 <da7b815d-3da8-38e5-9b25-b9cfb6878293@acm.org> <87jzxot0jk.fsf@metaspace.dk>
 <b9a1c1b2-3baa-2cad-31ae-8b14e4ee5709@acm.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <b9a1c1b2-3baa-2cad-31ae-8b14e4ee5709@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/23 20:36, Bart Van Assche wrote:
> On 5/4/23 11:15, Andreas Hindborg wrote:
>> If it is still unclear to you why this effort was started, please do let
>> me know and I shall try to clarify further :)
> 
> It seems like I was too polite in my previous email. What I meant is that
> rewriting code is useful if it provides a clear advantage to the users of
> a driver. For null_blk, the users are kernel developers. The code that has
> been posted is the start of a rewrite of the null_blk driver. The benefits
> of this rewrite (making low-level memory errors less likely) do not 
> outweigh
> the risks that this effort will introduce functional or performance 
> regressions.
> 
I have to disagree here. While the null_blk driver in itself is 
certainly not _that_ useful, it does provide a good sounding board if 
all the design principles of the linux block layer can be adequately 
expressed in Rust.

And by posting this driver you just proved that, and we all have a 
better understanding what would be needed to convert old or create new 
drivers.

But I guess we'll have a longer discussion at LSF :-)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

