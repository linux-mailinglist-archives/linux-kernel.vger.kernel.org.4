Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B4C68F0A7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 15:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjBHOYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 09:24:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjBHOYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 09:24:35 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62DBC3B0EB
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 06:24:34 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 950FC41;
        Wed,  8 Feb 2023 15:24:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1675866271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=drL93NXnDDD64IhXZUmZIWPeKMBa8824+z2G2QnTmD0=;
        b=MyAQ6ZVbAhn2BRsrnLu3YgakBYpoziFb8zMRyaVIt0++NAeEFE+2WdlnPw3iENBkrXTmLP
        02zF9gTRY0+oghhu10N062ZSUyAlx6ExGnFpIUiY8rTvILzXGiA6nbc6mf56hJFzO+owCr
        /CO1ATLJ2wbq4R5QdkGEWPg263WMohdXfEyo7m3fqtJjhPz2o+6soUk6duyAw+uCC3VqSX
        imIqKZiMJ4ZikNlFQuG4gqnbtmBisz0t+Kj59QwbZXGNYWjsaCPFWSM+c9M/qIEUUdhQYc
        i1EfBeX2Ra/H/0dfX06di+kcq6ByWfMAFNeysFUMkG8IhKC71Sv1XeS6w5gNZg==
MIME-Version: 1.0
Date:   Wed, 08 Feb 2023 15:24:31 +0100
From:   Michael Walle <michael@walle.cc>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, stable <stable@kernel.org>
Subject: Re: [PATCH v2] mtd: spi-nor: fix memory leak when using
 debugfs_lookup()
In-Reply-To: <Y+Ot0FXLgrSoLy7Q@kroah.com>
References: <20230208125758.1515806-1-gregkh@linuxfoundation.org>
 <69fbf8b55dcb9c5c0a1a5d59b2248670@walle.cc> <Y+Ot0FXLgrSoLy7Q@kroah.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <e9c24836696de76959bbf808b2a90863@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2023-02-08 15:12, schrieb Greg Kroah-Hartman:
> On Wed, Feb 08, 2023 at 02:36:23PM +0100, Michael Walle wrote:
>> Am 2023-02-08 13:57, schrieb Greg Kroah-Hartman:
>> > When calling debugfs_lookup() the result must have dput() called on it,
>> > otherwise the memory will leak over time.
>> >
>> > Cc: Tudor Ambarus <tudor.ambarus@microchip.com>
>> > Cc: Pratyush Yadav <pratyush@kernel.org>
>> > Cc: Michael Walle <michael@walle.cc>
>> > Cc: Miquel Raynal <miquel.raynal@bootlin.com>
>> > Cc: Richard Weinberger <richard@nod.at>
>> > Cc: Vignesh Raghavendra <vigneshr@ti.com>
>> > Cc: linux-mtd@lists.infradead.org
>> > Cc: stable <stable@kernel.org>
>> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> > ---
>> > v2: fix up to work when module is removed and added, making the fix
>> >     much simpler.
>> >
>> >  drivers/mtd/spi-nor/debugfs.c | 1 +
>> >  1 file changed, 1 insertion(+)
>> >
>> > diff --git a/drivers/mtd/spi-nor/debugfs.c
>> > b/drivers/mtd/spi-nor/debugfs.c
>> > index ff895f6758ea..af41fbc09a97 100644
>> > --- a/drivers/mtd/spi-nor/debugfs.c
>> > +++ b/drivers/mtd/spi-nor/debugfs.c
>> > @@ -242,6 +242,7 @@ void spi_nor_debugfs_register(struct spi_nor *nor)
>> >
>> >  	d = debugfs_create_dir(dev_name(nor->dev), rootdir);
>> >  	nor->debugfs_root = d;
>> > +	dput(rootdir);
>> 
>> rootdir might either be the return value of debugfs_lookup() or
>> debugfs_create_dir(). dput() is probably wrong for the latter,
>> right? Also there is an early return, where the dput() is missing,
>> too.
> 
> {sigh}
> 
> Yeah, this is all wrong, sorry.  Let me fix this up again, properly.
> And to do it properly, let's have the module remove the directory if it
> is unloaded, like a good module should :)

There were some complications. IIRC you'd need to do reference counting,
to determine whether you are the last user of the rootdir. Other subsys
create an empty rootdir in their .init(). But that was hard to do in 
MTD.
Again memory is hazy.. Therefore, I resorted to create it on the fly if
there isn't already one.

Maybe you got some better/simpler idea :)

-michael
