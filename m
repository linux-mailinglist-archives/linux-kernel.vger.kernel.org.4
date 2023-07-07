Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB4B74B8DB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 23:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjGGVzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 17:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjGGVzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 17:55:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDE61FF6
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 14:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688766854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IR3UM/qERNeUL/EjPgvmk0ZZpn8WhkLUZx2wiiCSLjA=;
        b=M5q0D31kxgBZ6keatYpFl78vK2heboCSQKjl/DmXC+AC0P773ss+5F5szZ9LywRCVZyUO6
        amrIzZkcxC4gNL103pBdaGHT8p8X0La5gKuUcbyzViUNcI36Qrb+xbLGizuF2+hFfmffoF
        t9kvaA3CDr7hipHUfeTkqCabcuu7z0s=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-gHLKHAtfOnWRAeZ2DUlfRw-1; Fri, 07 Jul 2023 17:54:13 -0400
X-MC-Unique: gHLKHAtfOnWRAeZ2DUlfRw-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-63788123d11so24719166d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 14:54:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688766853; x=1691358853;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IR3UM/qERNeUL/EjPgvmk0ZZpn8WhkLUZx2wiiCSLjA=;
        b=kgk8/R1BeB6+4fWYSTfmO0AiWWhXr568Ij+FlxpSGrLfJMh6i5u4fTEJj4Ol3fc3l/
         I5fimlWFV5Xd3DSEoOSQVYIt+RAzy1D94icxWsIDvEX3V+7xz6YntAQgPY3DAQiMFW81
         CKf4cGaFFoySHFTvZDj2esRYaN8vFvrLvqEl3KAkzPszN7V/hNI+/LDYWRy7JlC5uXGE
         0TZZhOECqXUbbjoQCw36pWQaZpuHWMJdWSeXG3LCRr8AcUAabTasPRLOeaZhaIgAvk6w
         05meVV7KKarIAGZzAbQE04ekw/ABPf08DEPTYGWdSwgRtXNEkEptWoPptT0ACiznK5aU
         lIfw==
X-Gm-Message-State: ABy/qLaSlMRrsLci65r7DUQ0saOvuCRyOEBo6LIxREW0gUIiFzSl6EHj
        taKYX//sGkdA0Ne1khwfAC2m0x8tIqSFO6xJvM3SS+fmzOKhSh1+r2kli+ltDvosn68YfC6euMw
        SCNWEtNlbDTtWyNdILvgNlo5W
X-Received: by 2002:a0c:cc10:0:b0:636:439b:a6de with SMTP id r16-20020a0ccc10000000b00636439ba6demr5936525qvk.13.1688766852899;
        Fri, 07 Jul 2023 14:54:12 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGy4rbv/6VC4l33AqtqHlOn3FLNo2hdcdd4j6YFakTEWNmLX49tDyvOehAct9nxQ75kSv1gPA==
X-Received: by 2002:a0c:cc10:0:b0:636:439b:a6de with SMTP id r16-20020a0ccc10000000b00636439ba6demr5936517qvk.13.1688766852667;
        Fri, 07 Jul 2023 14:54:12 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c62:8200:4d3e:bd5a:7e0a:133a? ([2600:4040:5c62:8200:4d3e:bd5a:7e0a:133a])
        by smtp.gmail.com with ESMTPSA id x10-20020a0ce24a000000b0063659410b04sm2470697qvl.107.2023.07.07.14.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 14:54:12 -0700 (PDT)
Message-ID: <79af2eab7409b75f5a2386fbd82c339111d6deab.camel@redhat.com>
Subject: Re: Regression from "ACPI: OSI: Remove Linux-Dell-Video _OSI
 string"? (was: Re: Bug#1036530: linux-signed-amd64: Hard lock up of system)
From:   Lyude Paul <lyude@redhat.com>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        Nick Hastings <nicholaschastings@gmail.com>,
        Lukas Wunner <lukas@wunner.de>, kherbst@redhat.com
Cc:     Salvatore Bonaccorso <carnil@debian.org>, 1036530@bugs.debian.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Date:   Fri, 07 Jul 2023 17:54:11 -0400
In-Reply-To: <fe0ab1fa-6ed6-dc64-8165-8fc70669317b@amd.com>
References: <168471337231.1913606.15905047692536779158.reportbug@xps>
         <ZHKrC4/G6ZyvRReI@xps> <ZHL5cCNUzVdleiag@eldamar.lan>
         <ab12984e-be17-903d-ba0a-f9c85b8c544f@amd.com> <ZHP4IqxBUPuVRvRV@xps>
         <09e24386-de63-e9e9-9e7f-5d04bad62d83@amd.com> <ZHQhPcKUF76Kplwm@xps>
         <ZHUt9xQKCwCflvVC@xps> <8537d965-ddf4-7f45-6459-d5acf520376e@amd.com>
         <ZHWfMBeAONerAJmd@xps> <ZHfa/wQlaVCeUC22@xps>
         <fe0ab1fa-6ed6-dc64-8165-8fc70669317b@amd.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-06-01 at 11:18 -0500, Limonciello, Mario wrote:
> +Lyude, Lukas, Karol
>=20
> On 5/31/2023 6:40 PM, Nick Hastings wrote:
> > Hi,
> >=20
> > * Nick Hastings <nicholaschastings@gmail.com> [230530 16:01]:
> > > * Mario Limonciello <mario.limonciello@amd.com> [230530 13:00]:
> > <snip>
> > > > As you're actually loading nouveau, can you please try nouveau.runp=
m=3D0 on
> > > > the kernel command line?
> > > I'm not intentionally loading it. This machine also has intel graphic=
s
> > > which is what I prefer. Checking my
> > > /etc/modprobe.d/blacklist-nvidia-nouveau.conf
> > > I see:
> > >=20
> > > blacklist nvidia
> > > blacklist nvidia-drm
> > > blacklist nvidia-modeset
> > > blacklist nvidia-uvm
> > > blacklist ipmi_msghandler
> > > blacklist ipmi_devintf
> > >=20
> > > So I thought I had blacklisted it but it seems I did not. Since I do =
not
> > > want to use it maybe it is better to check if the lock up occurs with
> > > nouveau blacklisted. I will try that now.
> > I blacklisted nouveau and booted into a 6.1 kernel:
> > % uname -a
> > Linux xps 6.1.0-9-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.27-1 (2023-05=
-08) x86_64 GNU/Linux
> >=20
> > It has been running without problems for nearly two days now:
> > % uptime
> >   08:34:48 up 1 day, 16:22,  2 users,  load average: 1.33, 1.26, 1.27
> >=20
> > Regards,
> >=20
> > Nick.
>=20
> Thanks, that makes a lot more sense now.
>=20
> Nick, Can you please test if nouveau works with runtime PM in the
> latest 6.4-rc?
>=20
> If it works in 6.4-rc, there are probably nouveau commits that need
> to be backported to 6.1 LTS.
>=20
> If it's still broken in 6.4-rc, I believe you should file a bug:
>=20
> https://gitlab.freedesktop.org/drm/nouveau/
>=20
>=20
> Lyude, Lukas, Karol
>=20
> This thread is in relation to this commit:
>=20
> 24867516f06d ("ACPI: OSI: Remove Linux-Dell-Video _OSI string")
>=20
> Nick has found that runtime PM is *not* working for nouveau.
>=20
> If you recall we did 24867516f06d because 5775b843a619 was
> supposed to have fixed it.

Gotcha, I guess keep me updated since it seems like things -might- be worki=
ng
from what I gathered here? Happy to look further if they find that 6.4-rc i=
s
broken though

>=20

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

