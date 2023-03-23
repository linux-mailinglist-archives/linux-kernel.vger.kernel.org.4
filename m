Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6666C5C7D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 03:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjCWCKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 22:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjCWCKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 22:10:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D782706
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 19:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679537402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2neQvZ7Wrkn72CUBUMcH+3GLPvcm+NoezLLcDD3fPlg=;
        b=AHUbtyDPMU396Ecn2FPcBYSo/o8U0CzXSVXb3Psm3mOVM6kaigHC3A9K972Nc3YFBLUGPc
        2w/5NR3QcYhzl9u7lonxl5wMdNJDGRH9uyt8ah/HZISTjClg5NFnMpXQQsvpKA/wMx6boM
        0BhC1j7Cwr/G3ezayP1QArsEx0bduPo=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-8E2VWykXM4iuEnG19TpqEw-1; Wed, 22 Mar 2023 22:10:00 -0400
X-MC-Unique: 8E2VWykXM4iuEnG19TpqEw-1
Received: by mail-pj1-f70.google.com with SMTP id j3-20020a17090a94c300b0024018f0656cso517082pjw.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 19:10:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679537400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2neQvZ7Wrkn72CUBUMcH+3GLPvcm+NoezLLcDD3fPlg=;
        b=d4NYgPqQja9ioVUqIZAcrvH0MGWa16R3XYCa8r+4x5kP6FDzpeDddjPTpBfaEbZqNL
         4D/JnogXHzX4bvK7gK3oG3vUQ9ol+wcQY+EME9NUZnWNdXHRfbiaqEzmNDt2w4RA3fKI
         tWAXsgC+82PgVfbDZ/7N+Mb94ZGdPaQ+XMqPor2s4VZl3QEVxsi5pbRAXLVWDiy2lI1o
         XTZIo3n25rImNayRVcdMRnFFrFT8MjpKLzryahxv7BVjbwQ2Gi0Xb0S4q9FaguIgq4o/
         9VhpuhedGA0/WxD/iD0nkXx2SkdO14ylhQkGPpQ4ir4vvSOFDsYa/wnqBoWmMvjXz1t/
         SRvw==
X-Gm-Message-State: AO0yUKWrLYfz+x15VODef5aKT4Oe/OwPilFNCt9cg4QWdZPDp5qI56+9
        gTYM8cU6SmwijjPmhSaIZxsbzhGD0baKACMOVhNcaEi7GnFw/jP7vtEZGY5NEva748pWNbrp3jS
        SEMFwWiNZxWepRPVULPMJl27TH3on84NAXllt3cXU
X-Received: by 2002:a05:6a00:a02:b0:624:5886:4b4b with SMTP id p2-20020a056a000a0200b0062458864b4bmr3070752pfh.5.1679537399739;
        Wed, 22 Mar 2023 19:09:59 -0700 (PDT)
X-Google-Smtp-Source: AK7set+qIXrGpJSca3VWlnSSMX0FxixLB7TvUj8VZeXNeqk+NwfqhId2m9FOijcCr3XSckRmfUxy0IarUZZxDYpFEQ8=
X-Received: by 2002:a05:6a00:a02:b0:624:5886:4b4b with SMTP id
 p2-20020a056a000a0200b0062458864b4bmr3070746pfh.5.1679537399366; Wed, 22 Mar
 2023 19:09:59 -0700 (PDT)
MIME-Version: 1.0
References: <167875238571.8008.9808655454439667586@noble.neil.brown.name>
 <CALTww2916uiO8_ViJQXutO2BPasFmiUJtfz8MxW0HKjDzwGFeQ@mail.gmail.com> <167945548970.8008.8910680813298326328@noble.neil.brown.name>
In-Reply-To: <167945548970.8008.8910680813298326328@noble.neil.brown.name>
From:   Xiao Ni <xni@redhat.com>
Date:   Thu, 23 Mar 2023 10:09:48 +0800
Message-ID: <CALTww282qMHzLYfNdDNk6YnpBFz8QYN77MEzFayVj_Ccoz2c3Q@mail.gmail.com>
Subject: Re: [PATCH - mdadm] mdopen: always try create_named_array()
To:     NeilBrown <neilb@suse.de>
Cc:     Jes Sorensen <jes@trained-monkey.org>,
        Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
        Song Liu <song@kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        linux-raid <linux-raid@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nikolay Kichukov <hijacker@oldum.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 11:25=E2=80=AFAM NeilBrown <neilb@suse.de> wrote:
>
> On Wed, 22 Mar 2023, Xiao Ni wrote:
> > On Tue, Mar 14, 2023 at 8:08=E2=80=AFAM NeilBrown <neilb@suse.de> wrote=
:
> > >
> > >
> > > mdopen() will use create_named_array() to ask the kernel to create th=
e
> > > given md array, but only if it is given a number or name.
> > > If it is NOT given a name and is required to choose one itself using
> > > find_free_devnm() it does NOT use create_named_array().
> > >
> > > On kernels with CONFIG_BLOCK_LEGACY_AUTOLOAD not set, this can result=
 in
> > > failure to assemble an array.  This can particularly seen when the
> > > "name" of the array begins with a host name different to the name of =
the
> > > host running the command.
> > >
> > > So add the missing call to create_named_array().
> > >
> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217074
> >
> > Hi Neil
> >
> > I have two questions, hope you can help to understand the function
> > create_mddev better.
> >
> > Frist, from the comment7 of the bug you mentioned:
> >
> > There are two different sorts names.  Note that you almost
> > acknowledged this by writing "name for my md device node" while the
> > documentation only talks about names for "md devices", not for "md
> > device nodes".
> >
> > There are
> > 1/ there are names in /dev or /dev/md/ (device nodes)
> > 2/ there are names that appear in /proc/mdstat and in /sys/block/ (devi=
ces)
> >
> > Thanks for the clarification. But it looks like it doesn't work like
> > what you said.
> > For example:
> > mdadm -CR /dev/md/root -l0 -n2 /dev/sda /dev/sdc --name=3Dtest
> > cat /proc/mdstat
> > Personalities : [raid0]
> > md127 : active raid0 sdc[1] sda[0]
> >       3906764800 blocks super 1.2 512k chunks
> > cd /sys/block/md127/md/
> >
> > In /proc/mdstat and /sys/block, they all use md127 rather than the name=
(root)
>
> Try again with "CREATE names=3Dyes" in /etc/mdadm.conf.
>
> mdadm generally tries to keep:
>   - the names in /dev/
>   - the names in /dev/md/
>   - the names in /proc/mdstat
>   - the names stored in the metadata
>
> in sync.  It can only do this when:
>  - you enabled "names=3Dyes"
>  - you don't confuse it by specifying a device name (/dev/md/root) that
>    is different from the metadata names "test".
>
> If you don't have "names=3Dyes" then the name in /proc/mdstat and the nam=
e
> in /dev/md* will be numeric.  The name in /dev/md/ and the name in the
> metadata can be different and will usually be the same.
>
> If you explicitly give a different name with --name=3D than the device
> name then obviously they will be different.  If you then stop the array
> and restart with "mdadm -As" or "mdadm -I /dev/sda; mdadm -I /dev/sdb"
> then mdadm will create a name in /dev/md/ that matches the name in the
> metadata.

Hi Neil

My last email uses non plain text mode. So many people can't see it. I
send this again with plain text mode.

Thanks for your explanation.

It looks like I understand it. In the function create_mddev, it tries
to extract the number and name from dev(device node name) or
name(metadata name). If it doesn't use --name when creating a raid
device, it gets the number and name from dev.

1. If it can get a number, we use the mdNN as the raid name. So the
device node name and raid name are the same(.e.g md0).

2. If it can't get a number and doesn't set 'Create names=3Dyes', it
automatically chooses a number. In this case the device node name and
the raid name are different.

For example:
mdadm -CR /dev/md/root -l0 -n2 /dev/sda /dev/sdc
The device node name is md127, the raid name is root. Because it
doesn't specify --name, so the metadata name is root too.

mdadm -CR /dev/md/root -l0 -n2 /dev/sda /dev/sdc --name=3Dtest
The device node name is md127, the raid name is root, the metadata
name is test. When assembling raid device, it'll use md127 as the
device node name too. But the raid name will change to md_test. So
it's not a good command to create the raid device. If you want to
specify the raid name in /dev/md/root, it's better not to use --name.

3. If it can't get a number and sets 'Create names=3Dyes' in mdadm.conf,
it can use the raid name as the device node name.
For example:
mdadm -CR /dev/md/root -l0 -n2 /dev/sda /dev/sdc
The device node name is root, the raid name is root and the metadata
name is root too.

>
> >
> > Before this patch,  it creates a symbol link with the name root rather =
than test
> > ll /dev/md/root
> > lrwxrwxrwx. 1 root root 8 Mar 21 22:35 /dev/md/root -> ../md127
>
> That is what you asked it to do.
>
> >
> > So "test" which is specified by --name looks like it has little usage.
> >
>
> It is stored in the metadata.  You can see it in --examine output.  If
> you reassemble the array without specifying a device name, it will use
> the name "test".

So we can call it metadata name :)

>
> >
> > By the way, after this patch, the symbol link /dev/md/root can't be
> > created anymore.
> > Is it a regression problem?
>
> I cannot reproduce any problem like that.  Please provide a sequence of
> steps so that I can try to duplicate it.

In the next email, Mariusz has given the reproduction steps. And it's
another patch that causes the regression.

>
> >
> > Second, are there possibilities that the arguments "dev" and "name" of
> > function create_mddev
> > are null at the same time?
>
> No.  For Build or Create, dev is never NULL.  For Assemble and
> Incremental, name is never NULL.
>
>
> > After some tests, I found dev can't be null when creating a raid
> > device. It can be checked before
> > calling create_mddev. And we must get a name after creating a raid
> > device. So when assembling
> > a raid device, the name must not be null. So the dev and name can't be
> > null at the same time, right?
>
> Correct.

Thanks for the confirmation. Now there is a comment like this:
"If both name and dev are NULL, we choose a name 'mdXX' or 'mdpXX'".
I'll try to write some patches to optimize the function mddev_create
and those comments.

Best Regards
Xiao

