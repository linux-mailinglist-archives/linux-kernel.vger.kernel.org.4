Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7016C73F407
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 07:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjF0Fqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 01:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjF0Fqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 01:46:34 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F850173C
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 22:46:32 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-991aac97802so273966166b.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 22:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1687844790; x=1690436790;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1cDBmGMx1xvc7jnjL1kjpTGnBDqdA53Y3e0zN441FdY=;
        b=qTSHf9xI3mOKUo2mws9JBmy3RrLnpLJmxHunylpWtztFLUJcY8BrG9wRK/1d6YD8bC
         kLW3+oJwpnj0MLcfwHH/My9GA5fBkiHbOMNFMfZaSeoGeFAczjNhr0MuwuFTw7CW3ltX
         DzJFm6lXpJuRk6vqVYWhaPo54XbPmUUFvM4anCepAjHb4bv//6eGSwciR1hfu3zQFnEw
         g/KlbKmpeq+5/1uMCqJATyCEMQ/j7ntxl98uCjVSyY0si/K2dI+aeEr31OV7+Kxw8zEG
         N/ESfN5B0HzXs3P8DimcuKCg1IV/KQpysbbDv8DMaK9rJMHwQpGry8WQmciB+OAhwLoc
         aDEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687844790; x=1690436790;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1cDBmGMx1xvc7jnjL1kjpTGnBDqdA53Y3e0zN441FdY=;
        b=COYdc4xE4Dm1yKBSX5HNVJRRwkKWMOV2cv6NbI2pv7gZpqOXgjPd2yukvV8hmfwODV
         M+X3JmzRAEseMGehqaiROy+T6gWfeIseX34YdxIZZpflx5E5jIn+UFUmFmtZxjFjrrXe
         egpa2N9LJBBbda6tlat+1nIOsihF/dBnN5pGHpPKlBJP71N6y//GaUiQbTn/Ho0E2iMz
         fF2D/bb2IvsjfXr92pogOSepWrTUq9olhf6hJbstHUNuUBPn0mwSi5Pp5MeyrlHyoM04
         gMzhU/A3+mcR8UE6VxYn2DqZC7pzDJXM57Lqw58WxwWH2ec0V6PZWbIZSDZc0OUTpK92
         wgYA==
X-Gm-Message-State: AC+VfDyOPkXwZNYMiwN8IUwsPV7bS/RzSalHvfhI6pN0zMSDNqVR2Zdq
        rIToaNbNBmrEnyt6mkPF4WGfJHuRjgUK5lK40mQ=
X-Google-Smtp-Source: ACHHUZ6RQrHaBR03XPKt8Kn4xn0BhgYfw9D1DMDMEl7/SAQBUyBeP2XO5b4KIbbq7bhntxmsq1AUkQ==
X-Received: by 2002:a17:907:778e:b0:98d:f4a7:71cf with SMTP id ky14-20020a170907778e00b0098df4a771cfmr7403274ejc.62.1687844790514;
        Mon, 26 Jun 2023 22:46:30 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id qn1-20020a170907210100b0098e42bef731sm2741029ejb.169.2023.06.26.22.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 22:46:30 -0700 (PDT)
References: <20230626164752.1098394-1-nmi@metaspace.dk>
 <02730282-88b0-572e-439c-719cfef379bb@wdc.com>
 <87r0pygjp1.fsf@metaspace.dk>
 <7481472f-8950-0801-029c-85264b671c19@kernel.org>
User-agent: mu4e 1.10.3; emacs 28.2.50
From:   "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "open list:ZONEFS FILESYSTEM" <linux-fsdevel@vger.kernel.org>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] zonefs: do not use append if device does not support it
Date:   Tue, 27 Jun 2023 07:45:25 +0200
In-reply-to: <7481472f-8950-0801-029c-85264b671c19@kernel.org>
Message-ID: <87ilb9h2yz.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Damien Le Moal <dlemoal@kernel.org> writes:

> On 6/27/23 03:23, Andreas Hindborg (Samsung) wrote:
>>=20
>> Johannes Thumshirn <Johannes.Thumshirn@wdc.com> writes:
>>=20
>>> On 26.06.23 18:47, Andreas Hindborg wrote:
>>>> From: "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
>>>>
>>>> Zonefs will try to use `zonefs_file_dio_append()` for direct sync writ=
es even if
>>>> device `max_zone_append_sectors` is zero. This will cause the IO to fa=
il as the
>>>> io vector is truncated to zero. It also causes a call to
>>>> `invalidate_inode_pages2_range()` with end set to UINT_MAX, which is p=
robably
>>>> not intentional. Thus, do not use append when device does not support =
it.
>>>>
>>>
>>> I'm sorry but I think it has been stated often enough that for Linux Zo=
ne Append
>>> is a mandatory feature for a Zoned Block Device. Therefore this path is=
 essentially
>>> dead code as max_zone_append_sectors will always be greater than zero.
>>>
>>> So this is a clear NAK from my side.
>>=20
>> OK, thanks for clarifying =F0=9F=91=8D I came across this bugging out wh=
ile
>> playing around with zone append for ublk. The code makes sense if the
>> stack expects append to always be present.
>>=20
>> I didn't follow the discussion, could you reiterate why the policy is
>> that zoned devices _must_ support append?
>
> To avoid support fragmentation and for performance. btrfs zoned block dev=
ice
> support requires zone append and using that command makes writes much fas=
ter as
> we do not have to go through zone locking.
> Note that for zonefs, I plan to add async zone append support as well, li=
nked
> with O_APPEND use to further improve write performance with ZNS drives.
>

Thanks for clarifying, Damien =F0=9F=91=8D

BR Andreas

