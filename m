Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2F96C40F9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 04:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjCVDZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 23:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjCVDY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 23:24:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03681FDC;
        Tue, 21 Mar 2023 20:24:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 572F022D0C;
        Wed, 22 Mar 2023 03:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1679455495; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5HUPU/NvAx6yyFmtrjsJOMT3AAy9By0peBwop2K4l/Q=;
        b=roI4Ojf0uwGrOanHxKiViUVdgQY2Di5ZhWjbWOPks6jGirEp67xIkgfZGS4eA7WZRNYlYW
        6qNuNW4CT+/NZqeJBgFHJXdQkw4mWSYxA/tD1gsMoGgv/i/jiO6uluLqMi7tRwcDcTfFqV
        yjorQK/l3MQiXvBYClgt8WWsEJm7+ZM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1679455495;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5HUPU/NvAx6yyFmtrjsJOMT3AAy9By0peBwop2K4l/Q=;
        b=i78hzX+7jEoU2WUUpbxw5FYaLHyIxwrBBFzZXN10YzBE0BdZmyul4xjcUrH7fsFM46Ebe7
        eZLNmgBiEPP8/GDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B6EB313582;
        Wed, 22 Mar 2023 03:24:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id U/a9GwR1GmReNAAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 22 Mar 2023 03:24:52 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Xiao Ni" <xni@redhat.com>
Cc:     "Jes Sorensen" <jes@trained-monkey.org>,
        "Mariusz Tkaczyk" <mariusz.tkaczyk@linux.intel.com>,
        "Song Liu" <song@kernel.org>,
        "Linux regressions mailing list" <regressions@lists.linux.dev>,
        "linux-raid" <linux-raid@vger.kernel.org>,
        "LKML" <linux-kernel@vger.kernel.org>,
        "Nikolay Kichukov" <hijacker@oldum.net>
Subject: Re: [PATCH - mdadm] mdopen: always try create_named_array()
In-reply-to: <CALTww2916uiO8_ViJQXutO2BPasFmiUJtfz8MxW0HKjDzwGFeQ@mail.gmail.com>
References: <167875238571.8008.9808655454439667586@noble.neil.brown.name>,
 <CALTww2916uiO8_ViJQXutO2BPasFmiUJtfz8MxW0HKjDzwGFeQ@mail.gmail.com>
Date:   Wed, 22 Mar 2023 14:24:49 +1100
Message-id: <167945548970.8008.8910680813298326328@noble.neil.brown.name>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Mar 2023, Xiao Ni wrote:
> On Tue, Mar 14, 2023 at 8:08=E2=80=AFAM NeilBrown <neilb@suse.de> wrote:
> >
> >
> > mdopen() will use create_named_array() to ask the kernel to create the
> > given md array, but only if it is given a number or name.
> > If it is NOT given a name and is required to choose one itself using
> > find_free_devnm() it does NOT use create_named_array().
> >
> > On kernels with CONFIG_BLOCK_LEGACY_AUTOLOAD not set, this can result in
> > failure to assemble an array.  This can particularly seen when the
> > "name" of the array begins with a host name different to the name of the
> > host running the command.
> >
> > So add the missing call to create_named_array().
> >
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217074
>=20
> Hi Neil
>=20
> I have two questions, hope you can help to understand the function
> create_mddev better.
>=20
> Frist, from the comment7 of the bug you mentioned:
>=20
> There are two different sorts names.  Note that you almost
> acknowledged this by writing "name for my md device node" while the
> documentation only talks about names for "md devices", not for "md
> device nodes".
>=20
> There are
> 1/ there are names in /dev or /dev/md/ (device nodes)
> 2/ there are names that appear in /proc/mdstat and in /sys/block/ (devices)
>=20
> Thanks for the clarification. But it looks like it doesn't work like
> what you said.
> For example:
> mdadm -CR /dev/md/root -l0 -n2 /dev/sda /dev/sdc --name=3Dtest
> cat /proc/mdstat
> Personalities : [raid0]
> md127 : active raid0 sdc[1] sda[0]
>       3906764800 blocks super 1.2 512k chunks
> cd /sys/block/md127/md/
>=20
> In /proc/mdstat and /sys/block, they all use md127 rather than the name(roo=
t)

Try again with "CREATE names=3Dyes" in /etc/mdadm.conf.

mdadm generally tries to keep:
  - the names in /dev/
  - the names in /dev/md/
  - the names in /proc/mdstat
  - the names stored in the metadata

in sync.  It can only do this when:
 - you enabled "names=3Dyes"
 - you don't confuse it by specifying a device name (/dev/md/root) that
   is different from the metadata names "test".

If you don't have "names=3Dyes" then the name in /proc/mdstat and the name
in /dev/md* will be numeric.  The name in /dev/md/ and the name in the
metadata can be different and will usually be the same.

If you explicitly give a different name with --name=3D than the device
name then obviously they will be different.  If you then stop the array
and restart with "mdadm -As" or "mdadm -I /dev/sda; mdadm -I /dev/sdb"
then mdadm will create a name in /dev/md/ that matches the name in the
metadata.

>=20
> Before this patch,  it creates a symbol link with the name root rather than=
 test
> ll /dev/md/root
> lrwxrwxrwx. 1 root root 8 Mar 21 22:35 /dev/md/root -> ../md127

That is what you asked it to do.

>=20
> So "test" which is specified by --name looks like it has little usage.
>=20

It is stored in the metadata.  You can see it in --examine output.  If
you reassemble the array without specifying a device name, it will use
the name "test".

>=20
> By the way, after this patch, the symbol link /dev/md/root can't be
> created anymore.
> Is it a regression problem?

I cannot reproduce any problem like that.  Please provide a sequence of
steps so that I can try to duplicate it.

>=20
> Second, are there possibilities that the arguments "dev" and "name" of
> function create_mddev
> are null at the same time?

No.  For Build or Create, dev is never NULL.  For Assemble and
Incremental, name is never NULL.


> After some tests, I found dev can't be null when creating a raid
> device. It can be checked before
> calling create_mddev. And we must get a name after creating a raid
> device. So when assembling
> a raid device, the name must not be null. So the dev and name can't be
> null at the same time, right?

Correct.

NeilBrown


>=20
> Best Regards
> Xiao
>=20
>=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  mdopen.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/mdopen.c b/mdopen.c
> > index d18c931996d2..810f79a3d19a 100644
> > --- a/mdopen.c
> > +++ b/mdopen.c
> > @@ -370,6 +370,7 @@ int create_mddev(char *dev, char *name, int autof, in=
t trustworthy,
> >                 }
> >                 if (block_udev)
> >                         udev_block(devnm);
> > +               create_named_array(devnm);
> >         }
> >
> >         sprintf(devname, "/dev/%s", devnm);
> > --
> > 2.39.2
> >
>=20
>=20

