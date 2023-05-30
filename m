Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079D7717138
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 01:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbjE3XEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 19:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233468AbjE3XEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 19:04:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50C4EC;
        Tue, 30 May 2023 16:04:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79C076181B;
        Tue, 30 May 2023 23:04:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E8EFC433D2;
        Tue, 30 May 2023 23:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685487878;
        bh=nmCxxkdcGAW8i+jZq5LyWD2wJfMQHxP2xZqU+KCy38k=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=aZMNEE+LqE57xeVo9wB3CivHR/y/CXj93mgpisrKTuoUs/JouoCFFFAl0+wWHPufv
         LhZqLhYmQFbYbN5M8AQ134Vqox+12eGT4d8uH/PIw54StrE2/bam4g2aTPDq8sjlaq
         yPm8zBzcibR5jpdvZ9ZMv25GOUcJgmzRMzeULmDgLSj9JXKRBoxP+G1f99QUzcnicb
         b0UGYas11v/AaEjGZ+8hLmLvLv2YZsV5lqgKCDcx+pp+Qyttn0ruZtyyeqHn3q1+XY
         gZWUxc4mvFThSHR8P4Ga4c9RDKZZ7IqA8neKVxyhIeZ1r57z+zF6ezAJXVSgyqpqp0
         MDmj5ia17/7cQ==
Message-ID: <fb2f0b6a4202d08857bc08a5507a62d7d9adaf78.camel@kernel.org>
Subject: Re: [PATCH] security: keys: perform capable check only on
 privileged operations
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Paul Moore <paul@paul-moore.com>,
        Christian =?ISO-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org, David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 31 May 2023 02:04:35 +0300
In-Reply-To: <CAHC9VhSbZ5YheAVec5a=Xht85mNu6wRjeYaoqPGSiHjFP2NN6Q@mail.gmail.com>
References: <20230511123252.723185-1-cgzones@googlemail.com>
         <CAHC9VhTcso+RTEOkGOCDxyMscznEXrUhp+quDWvATUhEzEOhRQ@mail.gmail.com>
         <CAJ2a_DfRGq+Cg_U7+Rsie9Bywxquu9CuMwYUGNv3+Sg9=wt9Og@mail.gmail.com>
         <CAHC9VhSbZ5YheAVec5a=Xht85mNu6wRjeYaoqPGSiHjFP2NN6Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-05-25 at 17:25 -0400, Paul Moore wrote:
> > A minor inconvenience is the number of needed arguments (and the
> > actual code after inlining should be the same to the inner scope in
> > the end).
>=20
> Well, lucky for you, Jarkko and David maintain the keys code, not me,
> and Jarkko seems to like your patch just fine :)
>=20
> Jarkko, I assume you'll be taking this via the keys tree?

I just picked it and mirrored to linux-next.

I think it is super important change because it tones down the human
error (a little bit at least). You could say improves user experience
kind of I guess :-)

BR, Jarkko

