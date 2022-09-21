Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9A15C008A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 16:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbiIUO7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 10:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiIUO6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 10:58:54 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E606E89F
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 07:57:09 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id h194so5237570iof.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 07:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date;
        bh=hllEYxW7NsLIs9BxyKkI80/JYA+jxi2TNvDqwFspVTQ=;
        b=zRd+ASngO80XK6wz9GY4RXmrP2PfVaUEHPGr/LtU+8SG2JyHQeZOP9ZSbJIi4tRygw
         kCaEaBGHJJBFBc/UOxidK5GxrXpprMfL1OQq74jKvqbDBawXEE1eJWJSmP7Hfzzx4y69
         dP3LIurDHzU7q1VmoHrvJ7RLEi0kV5MPossBlHUlQfnQ/ztrAm8og0UEU8tTx6UTQ8p/
         vR5IK9+AdKohw2XC34CgulB2ffMqn85ig6xRbU/fgOSJufU4/feIOhihEzaWg0oznHVI
         fDXAGb3G+AWb/wGH03CoFC5SX0K9JROfStWyGty/ymIIF4dC3CnNEN0VH7pOyisdQ+Qk
         bXVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=hllEYxW7NsLIs9BxyKkI80/JYA+jxi2TNvDqwFspVTQ=;
        b=uZ54MUIRkzscqhpVeF9rtf6LgVhg/yTE62ND3AaUwD6bkKlOf1j0fShQz218qBPto2
         5SwxNFD+VlVtQVUHaCFZzejrSoIkw1Ajdd4v86yDPOe4biuyZhYuhaRTT1Ifqfx8BpbA
         42S3MrcV0AcL1qal8gzLAmsUJfu1nhFHvDqNeGAiNlF7+ieeqW7N0swQuQcKRwOeAX6X
         9uQcKi48jI9/nU/R12V7NepD53nWae0FhwI20DYfFCxbmIxmo1D2SYbT2HrAFEYLFkqc
         hnN7bPU7DAHTZ1gbmIr8a+QsqrYS5NXi2XeD/jiBImorAKKMJhx/biaUWDTDjIjXWV4s
         81gQ==
X-Gm-Message-State: ACrzQf2WZQsH3uO/wzP95XA7KXLvRe6coCSz1y25tOcIMu/GQWVvTkT4
        kwk6MjWt9uQkfubTDlEwSlm75swMQ5LAuw==
X-Google-Smtp-Source: AMsMyM6gfJ0QxVIXyl6uTDviE8hjyB8sEV+XmAWYwTCskwgn2uYAlG3uY5TJIKGr2enjFCWiQtCKFA==
X-Received: by 2002:a05:6638:13cb:b0:33f:336c:34ae with SMTP id i11-20020a05663813cb00b0033f336c34aemr12834269jaj.317.1663772217433;
        Wed, 21 Sep 2022 07:56:57 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id p7-20020a92c107000000b002eac38773cdsm1041001ile.82.2022.09.21.07.56.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 07:56:56 -0700 (PDT)
Message-ID: <cecf4c71-14be-4ff8-df83-cfd1da102bcf@kernel.dk>
Date:   Wed, 21 Sep 2022 08:56:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
From:   Jens Axboe <axboe@kernel.dk>
Subject: Re: regression caused by block: freeze the queue earlier in
 del_gendisk
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Christoph Hellwig <hch@lst.de>,
        Dusty Mabe <dusty@dustymabe.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <Yxr4SD4d0rZ9TZik@T590> <20220912071618.GA4971@lst.de>
 <Yx/jLTknQm9VeHi4@T590> <95cbd47d-46ed-850e-7d4f-851b35d03069@dustymabe.com>
 <f2c28043-59e6-0aee-b8bf-df38525ee899@leemhuis.info>
 <d39e9149-fcb6-1f7c-4c19-234e74f286f8@kernel.dk>
 <20220920141217.GA12560@lst.de>
 <9594af4b-eb16-0a51-9a4a-e21bbce3317d@kernel.dk>
 <6a3660b2-fa7d-14a2-6977-f50926ad369c@leemhuis.info>
 <c7c909aa-71d9-b43c-293e-d4801a00861e@kernel.dk> <Yysj6AXQ44/el4pS@kroah.com>
Content-Language: en-US
In-Reply-To: <Yysj6AXQ44/el4pS@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 8:47 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Sep 21, 2022 at 08:34:26AM -0600, Jens Axboe wrote:
> > On 9/21/22 3:25 AM, Thorsten Leemhuis wrote:
> > > On 20.09.22 16:14, Jens Axboe wrote:
> > >> On 9/20/22 8:12 AM, Christoph Hellwig wrote:
> > >>> On Tue, Sep 20, 2022 at 08:05:06AM -0600, Jens Axboe wrote:
> > >>>> Christoph and I discussed this one last week, and he has a plan to try
> > >>>> a flag approach. Christoph, did you get a chance to bang that out? Would
> > >>>> be nice to get this one wrapped up.
> > >>>
> > >>> I gave up on that as it will be far too much change so late in
> > >>> the cycle and sent you the revert yesterday.
> > >>
> > >> Gotcha, haven't made it all the way through the emails of the morning yet.
> > >> I'll queue it up.
> > >
> > > Thx to both of you for taking care of this.
> > >
> > > Nitpicking: that patch is missing a "CC: stable@..." tag to ensure
> > > automatic and quick backporting to 5.19.y. Or is the block layer among
> > > the subsystems that prefer to handle such things manually?
> > >
> > > Ohh, and a fixes tag might have been good as well; a "Link:" tag
> > > pointing to the report, too. If either would have been there, regzbot
> > > would have noticed Christoph's patch posting and I wouldn't have
> > > bothered you yesterday. :-) But whatever, not that important.
> >
> > We'll just have to ensure we ping stable on it when it goes in.
>
> If you have a git id that is not going to change, I can watch out for it
> to land in Linus's tree...

This is the one:

commit 4c66a326b5ab784cddd72de07ac5b6210e9e1b06 (origin/block-6.0, block-6.0)
Author: Christoph Hellwig <hch@lst.de>
Date:   Mon Sep 19 16:40:49 2022 +0200

    Revert "block: freeze the queue earlier in del_gendisk"

Thanks Greg!

-- 
Jens Axboe
