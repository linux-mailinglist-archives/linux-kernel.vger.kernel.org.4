Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9100E66BB04
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 10:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjAPJzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 04:55:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjAPJz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 04:55:27 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178D717CC3;
        Mon, 16 Jan 2023 01:54:46 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AFAA867640;
        Mon, 16 Jan 2023 09:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673862884; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xi/jusoH+SfQb/aLv3BrlJRJEe2ihoujDNBUkCO8aR4=;
        b=e1gWyOnlQXi7+yuK0+pmHqv+TAbXl2YsxyTasBYsowUnfZzCS8ax9A4nspC/PgLPt1c9kg
        uCi7jlwp8Wsyukc/b5raWfxm0TTVZRQFEEsbqTjyeNM9kiuc8KPY7YpNIq2u/VqxEtZ0XB
        JyYXXCFwTRxkyCAZnirQd3fbxQBiL7M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673862884;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xi/jusoH+SfQb/aLv3BrlJRJEe2ihoujDNBUkCO8aR4=;
        b=H18sgnI7WJe2w8ESgGwUoGhdRppaI3tu0lZcr5VBmwnXYoRi2KyFIS/qHiqFIE2WI4zZNK
        3C++/4SdHkxQjkBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9923C138FE;
        Mon, 16 Jan 2023 09:54:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4NxVJeQexWPePgAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 16 Jan 2023 09:54:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 16EC7A0746; Mon, 16 Jan 2023 10:54:44 +0100 (CET)
Date:   Mon, 16 Jan 2023 10:54:44 +0100
From:   Jan Kara <jack@suse.cz>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, Jan Kara <jack@suse.cz>,
        Ming Lei <ming.lei@redhat.com>,
        "yukuai (C)" <yukuai3@huawei.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kbusch@kernel.org, Laibin Qiu <qiulaibin@huawei.com>
Subject: Re: [PATCH RESEND v2 5/5] sbitmap: correct wake_batch recalculation
 to avoid potential IO hung
Message-ID: <20230116095444.z77f6lvvxeys7zdi@quack3>
References: <20221222143353.598042-1-shikemeng@huaweicloud.com>
 <20221222143353.598042-6-shikemeng@huaweicloud.com>
 <20221222134146.khucy5afnxwl75px@quack3>
 <d00297d7-a77a-770a-1cd7-1632f8ae77e0@huaweicloud.com>
 <3662b1aa-546b-e4e0-3705-0bc5626067f6@huaweicloud.com>
 <f8df9153-eeff-f3ca-c4c2-2be0cf876298@huaweicloud.com>
 <16d02f7b-8e0e-097c-63bc-ef83eb9cb05b@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16d02f7b-8e0e-097c-63bc-ef83eb9cb05b@huaweicloud.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 16-01-23 10:15:08, Kemeng Shi wrote:
> 
> 
> on 1/3/2023 10:12 AM, Kemeng Shi wrote:
> > Friendly ping...
> > 
> > on 12/26/2022 4:57 PM, Yu Kuai wrote:
> >> 在 2022/12/26 15:50, Yu Kuai 写道:
> >>
> >>>> why using
> >>>> wake batch of 4 is safe for cards with say 32 tags in case active_users is
> >>>> currently 32. Because I don't see why that is correct either.
> >>>>
> >>
> >> I see, you guys are worried that during the period that some hctx
> >> complete all it's not idle yet. It's right waiter might wait for
> >> other hctx to become idle to be awaken in this case. However, I'm
> >> not sure which way is better.
> >>
> >> Ming, do you have any idea?
> >>
> >> Thanks,
> >> Kuai
> >>
> > 
> Hi Jan. The magic batch 4 seems just for performance initially while
> lacks of full consideration. And there is no better solution provided
> in futher. Do you have any suggestion that I can do to make more
> progress.

Yeah, since there was not any good reasoning behind the magic batch of size
4, feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

to this patch.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
