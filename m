Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADC36C40A4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 04:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjCVDBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 23:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjCVDBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 23:01:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AAB7570B9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 20:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679454036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JOIJJRSYJPLJPTd2GRDu3k3fbf9v92FQcFp9jB2hMk4=;
        b=K7zKq81n+ArZiKAM+/yOXpi9lYWWyVrD2myy5Sg17j7ADOgGrtH7C766caeQL/57fjkdsd
        AvFztgl7HtAuaAD+yVQS65lFNHQ4h6cth7VfqfCIGLI+qkRPm7LpNUmmIZM5y3eWH1ughr
        kGtZsE85gceyQ2z6rNC2W0VF7Pvgr68=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-2_RShr6qMfmRvfsQKHVY-w-1; Tue, 21 Mar 2023 23:00:34 -0400
X-MC-Unique: 2_RShr6qMfmRvfsQKHVY-w-1
Received: by mail-pj1-f72.google.com with SMTP id q8-20020a17090ad38800b0023f116f305bso8077180pju.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 20:00:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679454033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JOIJJRSYJPLJPTd2GRDu3k3fbf9v92FQcFp9jB2hMk4=;
        b=J1CPwLKoQ85BOuZW/ojiSF7QO+dGC5D464OMOfuWDdz/XWcnHcIfChF6IR+739vPCJ
         on6IJ1VcMGQfLrx2nKgF1W4pRGRO52hqis8fVhYGZxvV7RIC/7RyW3a11R441QwHhm/w
         p2xagfzClJbHz/KvlOyls6T3+se95SNs7Z/C5Ah++D7jU4pN3XTLeTakmxts4L4jK+ad
         k/IZx4wHwbvfjvqbMtug4NTrinZBQLMhKbRdhso0A7gve/CNo1zPqLyh+muSHZktH3aj
         T29IZubNu14LhCyvgYSy6EkTMsX96vlnF9J7RNG8mFxIg3IrAdc0oiHSxC+EMzCibsxc
         gPsA==
X-Gm-Message-State: AO0yUKX0kcdbemKyX7qRS5gE14XkYlsueXLxAfwm8ewldAjk1P33R1Ug
        zeUihA30N+k0Z6UhZgHGNEjVzvIRGXVaFjgVdtjpEyu1pOMqH8tEA1BIcmT78vfBQYyco7nXfzZ
        PSKBroxgEPG3u831nn4FKIo23FOlCR7Q3cl1syafC
X-Received: by 2002:a05:6a00:1741:b0:625:ce35:432c with SMTP id j1-20020a056a00174100b00625ce35432cmr1158689pfc.5.1679454032871;
        Tue, 21 Mar 2023 20:00:32 -0700 (PDT)
X-Google-Smtp-Source: AK7set+OLhW5K05NOdkAWcGB0tO28XfxJoJsLOqUHoqewkC8YHtyY8GS/pCKA/KQe5aZFhUh0RlGTpF7H+uDio60mew=
X-Received: by 2002:a05:6a00:1741:b0:625:ce35:432c with SMTP id
 j1-20020a056a00174100b00625ce35432cmr1158612pfc.5.1679454029570; Tue, 21 Mar
 2023 20:00:29 -0700 (PDT)
MIME-Version: 1.0
References: <167875238571.8008.9808655454439667586@noble.neil.brown.name>
In-Reply-To: <167875238571.8008.9808655454439667586@noble.neil.brown.name>
From:   Xiao Ni <xni@redhat.com>
Date:   Wed, 22 Mar 2023 11:00:18 +0800
Message-ID: <CALTww2916uiO8_ViJQXutO2BPasFmiUJtfz8MxW0HKjDzwGFeQ@mail.gmail.com>
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

On Tue, Mar 14, 2023 at 8:08=E2=80=AFAM NeilBrown <neilb@suse.de> wrote:
>
>
> mdopen() will use create_named_array() to ask the kernel to create the
> given md array, but only if it is given a number or name.
> If it is NOT given a name and is required to choose one itself using
> find_free_devnm() it does NOT use create_named_array().
>
> On kernels with CONFIG_BLOCK_LEGACY_AUTOLOAD not set, this can result in
> failure to assemble an array.  This can particularly seen when the
> "name" of the array begins with a host name different to the name of the
> host running the command.
>
> So add the missing call to create_named_array().
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217074

Hi Neil

I have two questions, hope you can help to understand the function
create_mddev better.

Frist, from the comment7 of the bug you mentioned:

There are two different sorts names.  Note that you almost
acknowledged this by writing "name for my md device node" while the
documentation only talks about names for "md devices", not for "md
device nodes".

There are
1/ there are names in /dev or /dev/md/ (device nodes)
2/ there are names that appear in /proc/mdstat and in /sys/block/ (devices)

Thanks for the clarification. But it looks like it doesn't work like
what you said.
For example:
mdadm -CR /dev/md/root -l0 -n2 /dev/sda /dev/sdc --name=3Dtest
cat /proc/mdstat
Personalities : [raid0]
md127 : active raid0 sdc[1] sda[0]
      3906764800 blocks super 1.2 512k chunks
cd /sys/block/md127/md/

In /proc/mdstat and /sys/block, they all use md127 rather than the name(roo=
t)

Before this patch,  it creates a symbol link with the name root rather than=
 test
ll /dev/md/root
lrwxrwxrwx. 1 root root 8 Mar 21 22:35 /dev/md/root -> ../md127

So "test" which is specified by --name looks like it has little usage.

By the way, after this patch, the symbol link /dev/md/root can't be
created anymore.
Is it a regression problem?

Second, are there possibilities that the arguments "dev" and "name" of
function create_mddev
are null at the same time?
After some tests, I found dev can't be null when creating a raid
device. It can be checked before
calling create_mddev. And we must get a name after creating a raid
device. So when assembling
a raid device, the name must not be null. So the dev and name can't be
null at the same time, right?

Best Regards
Xiao


> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  mdopen.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/mdopen.c b/mdopen.c
> index d18c931996d2..810f79a3d19a 100644
> --- a/mdopen.c
> +++ b/mdopen.c
> @@ -370,6 +370,7 @@ int create_mddev(char *dev, char *name, int autof, in=
t trustworthy,
>                 }
>                 if (block_udev)
>                         udev_block(devnm);
> +               create_named_array(devnm);
>         }
>
>         sprintf(devname, "/dev/%s", devnm);
> --
> 2.39.2
>

