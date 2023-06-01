Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D8371EF25
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 18:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbjFAQeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 12:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjFAQeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 12:34:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07056128
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 09:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685637201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lKfNaN4l/MR8zlLzyVVW3/Ll4oj7wzuBoASQm/awxOs=;
        b=R9TqJXdwZO/16nglc0belNuDy2umOpByCMZBSSJ8Kuk3fR5th/5pDQPcdf+e4YVD0LHttL
        3hqFHACSTEe/UXAM/kRgh+LGeo00zzhpuF/hHzrNe9/8wA8pyI475+udb51o4xYfMZsvka
        zG2DdyDxDl3aYm2DBQGbXbLI1IxbS68=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-CqO_qo4oO7a_GGVTspWHsg-1; Thu, 01 Jun 2023 12:33:19 -0400
X-MC-Unique: CqO_qo4oO7a_GGVTspWHsg-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2af1cf1a118so29911fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 09:33:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685637198; x=1688229198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lKfNaN4l/MR8zlLzyVVW3/Ll4oj7wzuBoASQm/awxOs=;
        b=lDc+egFnBrH2POtslgrZYRFh7MSvlOFLA7oF44ZX0voXecXNeqxlMeSyZhoUE2uKY5
         83gioI5XK+2i425ph/upef6vO0RVpxsUJ29f1nJYQ1JDYpl5zZG1flkU/nYV2vY2lH5O
         AguWIGwIdHIbNkrcs55tGB2oFabYPJg0RLrzGByK/AOmF9VfFEaDVpGaz8HQ7ingxOH/
         bMhw5pk1s7q5hOqa4ZSgo07n43l3MoBSBc5IrLBllsaCJqhxP8EDvJCzUokWKhD/W0oH
         VOz9mRs/apErDnx6TnyBPl8SnHqgoePdWJVWfvvjb2YwaKkoQyqhXfS4dsMBziecVBKz
         sKbA==
X-Gm-Message-State: AC+VfDzUtFDMUdPyj+N67BG4G9pWrQ96qoXqtwmpa2EQvMeXnW7aatXL
        Wl4EU8q8CW+iYQmO9x5Hm0BhpWB+YAK/DmglGFql2iPlSCnrKMmjsGmbcbjtlLnmyc0X1Llaimi
        s6BsNpxx8uSaNKk8gl9VQY7/fOEBuVzBE9oUao+kr
X-Received: by 2002:a2e:a4ac:0:b0:2b1:a69e:6a8e with SMTP id g12-20020a2ea4ac000000b002b1a69e6a8emr925280ljm.3.1685637198424;
        Thu, 01 Jun 2023 09:33:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6sX+gZm7ZA5+9vSBRoryBdVNamolMuCnhrtAuIzv4GVF3xl6ftjdZdgSxoZfJGJTNBJipxrwFfnfQLsuMLFeU=
X-Received: by 2002:a2e:a4ac:0:b0:2b1:a69e:6a8e with SMTP id
 g12-20020a2ea4ac000000b002b1a69e6a8emr925265ljm.3.1685637198130; Thu, 01 Jun
 2023 09:33:18 -0700 (PDT)
MIME-Version: 1.0
References: <168471337231.1913606.15905047692536779158.reportbug@xps>
 <ZHKrC4/G6ZyvRReI@xps> <ZHL5cCNUzVdleiag@eldamar.lan> <ab12984e-be17-903d-ba0a-f9c85b8c544f@amd.com>
 <ZHP4IqxBUPuVRvRV@xps> <09e24386-de63-e9e9-9e7f-5d04bad62d83@amd.com>
 <ZHQhPcKUF76Kplwm@xps> <ZHUt9xQKCwCflvVC@xps> <8537d965-ddf4-7f45-6459-d5acf520376e@amd.com>
 <ZHWfMBeAONerAJmd@xps> <ZHfa/wQlaVCeUC22@xps> <fe0ab1fa-6ed6-dc64-8165-8fc70669317b@amd.com>
In-Reply-To: <fe0ab1fa-6ed6-dc64-8165-8fc70669317b@amd.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Thu, 1 Jun 2023 18:33:07 +0200
Message-ID: <CACO55tsuO1kQUFfPdPFUHm4WEQseCR2tQSDhFRzR+8wOECZCyA@mail.gmail.com>
Subject: Re: Regression from "ACPI: OSI: Remove Linux-Dell-Video _OSI string"?
 (was: Re: Bug#1036530: linux-signed-amd64: Hard lock up of system)
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     Nick Hastings <nicholaschastings@gmail.com>,
        Lyude Paul <lyude@redhat.com>, Lukas Wunner <lukas@wunner.de>,
        Salvatore Bonaccorso <carnil@debian.org>,
        1036530@bugs.debian.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 1, 2023 at 6:18=E2=80=AFPM Limonciello, Mario
<mario.limonciello@amd.com> wrote:
>
> +Lyude, Lukas, Karol
>
> On 5/31/2023 6:40 PM, Nick Hastings wrote:
> > Hi,
> >
> > * Nick Hastings <nicholaschastings@gmail.com> [230530 16:01]:
> >> * Mario Limonciello <mario.limonciello@amd.com> [230530 13:00]:
> > <snip>
> >>> As you're actually loading nouveau, can you please try nouveau.runpm=
=3D0 on
> >>> the kernel command line?
> >> I'm not intentionally loading it. This machine also has intel graphics
> >> which is what I prefer. Checking my
> >> /etc/modprobe.d/blacklist-nvidia-nouveau.conf
> >> I see:
> >>
> >> blacklist nvidia
> >> blacklist nvidia-drm
> >> blacklist nvidia-modeset
> >> blacklist nvidia-uvm
> >> blacklist ipmi_msghandler
> >> blacklist ipmi_devintf
> >>
> >> So I thought I had blacklisted it but it seems I did not. Since I do n=
ot
> >> want to use it maybe it is better to check if the lock up occurs with
> >> nouveau blacklisted. I will try that now.
> > I blacklisted nouveau and booted into a 6.1 kernel:
> > % uname -a
> > Linux xps 6.1.0-9-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.27-1 (2023-05=
-08) x86_64 GNU/Linux
> >
> > It has been running without problems for nearly two days now:
> > % uptime
> >   08:34:48 up 1 day, 16:22,  2 users,  load average: 1.33, 1.26, 1.27
> >
> > Regards,
> >
> > Nick.
>
> Thanks, that makes a lot more sense now.
>
> Nick, Can you please test if nouveau works with runtime PM in the
> latest 6.4-rc?
>
> If it works in 6.4-rc, there are probably nouveau commits that need
> to be backported to 6.1 LTS.
>
> If it's still broken in 6.4-rc, I believe you should file a bug:
>
> https://gitlab.freedesktop.org/drm/nouveau/
>
>
> Lyude, Lukas, Karol
>
> This thread is in relation to this commit:
>
> 24867516f06d ("ACPI: OSI: Remove Linux-Dell-Video _OSI string")
>
> Nick has found that runtime PM is *not* working for nouveau.
>

keep in mind we have a list of PCIe controllers where we apply a
workaround: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git/tree/drivers/gpu/drm/nouveau/nouveau_drm.c?h=3Dv6.4-rc4#n682

And I suspect there might be one or two more IDs we'll have to add
there. Do we have any logs? And could anybody test if adding the
controller in play here does resolve the problem?

> If you recall we did 24867516f06d because 5775b843a619 was
> supposed to have fixed it.
>

