Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996D56B7FEB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjCMSFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCMSFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:05:46 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01AB12194C;
        Mon, 13 Mar 2023 11:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Transfer-Encoding
        :Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=G/ko5TGzuHEcgDJnamjpPEj0WHGMkQQVi8DJaI/SzYg=; b=QWADTLVQC188kv7oMbz4BHRYWc
        71WvmVgDBgXZR0ElQENg9v47nhT0sb7lTKLwph5P7XyH2GLBtfqGT+RNX6GsXSMSfD13TnQ5aPrRG
        CjXvEN34naTsP+EDdHO+a5mJJmUlcnG3I0FF4FYUiGBtNpG50K2RuWqC2BdUmWCKZxzleT6f2Cbd9
        dEvgDXovnxWdgy8/pk0byGAokVdVA7chwUS0yYjmvc6kr4JGIGtY2FwLMY+NzAnJyKhfngyRzRAQP
        zbyV4QKaoEUWvfq2FFU4TF4mVDG+yktLc0HGO4rbG3G528Yn5bQhz1cSw0jsrIP23K+7Rp8aWaan9
        HWFCgBlQ==;
Received: from [54.239.6.189] (helo=[192.168.11.210])
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pbmXp-001Tlb-1s;
        Mon, 13 Mar 2023 18:05:13 +0000
Message-ID: <5441d09dc213998042a337b7f411bd1662b604bc.camel@infradead.org>
Subject: Re: [PATCH v2 0/2] [RFC] virtio-rng entropy leak reporting feature
From:   Amit Shah <amit@infradead.org>
To:     bchalios@amazon.es, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, sgarzare@redhat.com,
        amit@kernel.org, graf@amazon.de, xmarcalx@amazon.co.uk
Date:   Mon, 13 Mar 2023 19:05:11 +0100
In-Reply-To: <e1c03136-b873-1f1d-8b06-d9186566fc0c@amazon.es>
References: <20230131145543.86369-1-bchalios@amazon.es>
         <Y9lBeymca9eFaJ33@zx2c4.com>
         <65d872db2e1be29bb03b43ed606e7cc9e74ec08d.camel@infradead.org>
         <e1c03136-b873-1f1d-8b06-d9186566fc0c@amazon.es>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Herbert / Jason / crypto maintainers,


On Mon, 2023-03-13 at 11:42 +0100, bchalios@amazon.es wrote:
> Hi Amit,
>=20
> Thanks for taking the time to look into this.
>=20
> On 3/2/23 5:55 PM, Amit Shah <amit@infradead.org> wrote:
> > CAUTION: This email originated from outside of the organization. Do not=
 click links or open attachments unless you can confirm the sender and know=
 the content is safe.
> >=20
> >=20
> >=20
> > Hey all,
> >=20
> > On Tue, 2023-01-31 at 17:27 +0100, Jason A. Donenfeld wrote:
> > > You sent a v2, but I'm not back until the 11th to provide comments on
> > > v1. I still think this isn't the right direction, as this needs tie-i=
ns
> > > to the rng to actually be useful. Please stop posting new versions of
> > > this for now, so that somebody doesn't accidentally merge it; that'd =
be
> > > a big mistake. I'll paste what I wrote you prior:
> >=20
> > I sat down to review the patchset but looks like there's some
> > background I'm not aware of.
> >=20
> > It looks like Babis has implemented the guest side here according to
> > the spec change that Michael has posted.
> >=20
> > Jason, do you have an alternative in mind?  In that case, we should
> > pick this up in the spec update thread instead.
>=20
> I am not sure what Jason meant here by "This needs to be integrated more =
closely with random.c itself, similar to how vmgenid works",
> but here's my take on this.
>=20
> The point of the patchset is to provide an implementation of Michael's sp=
ec on which we can discuss. It implements the HW API and it has
> some hooks showing how this API could be used. It is mainly directed towa=
rds the user-space where we did not have a proper API to consume
> VMGENID-like functionality. With regards to the random.c components it do=
es exactly what VMGENID does currently, i.e. whenever an entropy-leak
> is detected it uses the new random bytes provided by the virtio-rng devic=
e as entropy. This is as racy as VMGENID, as I mention in the cover
> letter of the patchset.

Yea, this does solve the race condition from the userspace pov, so does
look better.  Thanks for the details!

Not sure if Jason's back yet - but Herbert, or other crypto
maintainers, can you chime in from the crypto/rng perspective if this
looks sane?

Jason has previously NACKed the patch without follow-up, and I don't
want the patch to linger without a path to merging, especially when
it's not clear what Jason meant.

> However, the new spec does allow us to do things _correctly_, i.e. not re=
ly on asynchronous handling of events to re-seed the kernel. For example, w=
e
> could achieve something like that by making use of the "copy-on-leak" ope=
ration, so that a flag changes value before vCPUs get resumed, so we know
> when a leak has happened when needed, e.g. before returning random bytes =
to user-space. At least, that's what I remember us discussing during LPC.
> Jason, Michael, Alex, please keep me honest here :)
>=20
> Unfortunately, I am not very familiar with the random.c code and did not =
want to do something there that would most certainly be wrong, hence I post=
ed
> this as an RFC, asking for input on how we could achieve this better inte=
gration. Hopefully, when Jason is back from his vacation he can share his t=
houghts
> on this, but if yourself (or anyone else interested) have any ideas on ho=
w we could design this properly, I 'm happy to discuss!

Let's wait a couple more days for responses, otherwise I suggest you
resubmit to kickstart a new discussion, with the note that Jason had
something else in mind - so that it doesn't appear as though we're
trying to override that.

Thanks for the patience,

		Amit
