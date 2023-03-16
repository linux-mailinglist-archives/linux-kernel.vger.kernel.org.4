Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D9B6BCCD0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 11:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjCPKbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 06:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjCPKbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 06:31:07 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD294E1A6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 03:31:04 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id v21so1198060ple.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 03:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678962664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LaSPvmPSt93nNheKLzW291h2A9WkN7ApV5HQtl26YWo=;
        b=Dum/Rq0NIjZXk/W4AndokOhgSRTJbn43U/VgkdjLexY03UtbAen3XazOP9bL6qrPrU
         lKRDvWnpjbYPmGZ0Kv5laOAf0rQ4Ji34AZnXwwfHrvR5/k8Z7nA7QM108qg2NodWRL8K
         qBxtxmlxF51/pMs433XPxn5ay4iJYxvaSsOwTTfEDW4HzXcJz3e7AntTwcMGXT1n3hQv
         mSCl5Shr7oP8Kh5xvsVThMs+54hke52TVKpjjRFZaIwIuztPk9ITMiLt4g+I1nHapAKO
         wq88L4gUhhR+YmGCQKyIEHvo4CO7+1JjO/LQRiOilV8ZwVaesXJLBKh3P7DGTtvLgiHg
         GwTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678962664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LaSPvmPSt93nNheKLzW291h2A9WkN7ApV5HQtl26YWo=;
        b=Ash75Fvat4IOs0ntqHzM9QawgV2N9rR/Hz4d4VJB5S/WgWnk+Hdjd31YrNhSCsod0l
         d54tsBiZfCUXCNljyWtfxFUTTOJDJf2SWHxqUr8Iy7BiCxPd36gQWMjK4jdu0k9W3LzI
         smrC7JkdaxuALmO9zqmzNVVVDVQfn80a9rG7rZ6qHY+jcsEtMVsEKSpRAZA5+vBkzZQx
         N9B81oAObAXnBh+5NidKXHKycl8tYt8uWQkeGuJ+lXsl0WzkQ40alW/Vc9vy6TiZ26Q9
         +WWjXxYUaICA0eKiEV68fCfkgx1BltMk6lophCcfSbOD5MMLOTc42iB41tGLahY4uA1r
         pQAw==
X-Gm-Message-State: AO0yUKVtYD/9nrCwy0dE6PZwdwRfSuamnfzpo8ztjhLaX7K35zTrw4tL
        B5gCnh1hXTQnpcMumzkvkWfPAGOJQdbkVBVMZ6SJ9rJ+1KQ=
X-Google-Smtp-Source: AK7set//MPCx+TU+7KS757Fw88kx3Hyhv3abLM5v34Lh3B3OJ3L2f8xu3/tieBZp8nOltOxRRQhy4NPGCawZvQS90Qw=
X-Received: by 2002:a17:90a:5b01:b0:23c:fa47:e763 with SMTP id
 o1-20020a17090a5b0100b0023cfa47e763mr990712pji.0.1678962664074; Thu, 16 Mar
 2023 03:31:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230314075345.1325187-1-suagrfillet@gmail.com> <20230316092910.doolw3xiuwwakile@bogus>
In-Reply-To: <20230316092910.doolw3xiuwwakile@bogus>
From:   Song Shuai <suagrfillet@gmail.com>
Date:   Thu, 16 Mar 2023 10:30:52 +0000
Message-ID: <CAAYs2=gaTkA2f65SXkexxAUkSPxgaPNQGdkSKS4pYmJ3hO7z-Q@mail.gmail.com>
Subject: Re: [PATCH V2] arch_topology: Clear LLC sibling when cacheinfo teardown
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        conor.dooley@microchip.com, ionela.voinescu@arm.com,
        Pierre.Gondois@arm.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sudeep Holla <sudeep.holla@arm.com> =E4=BA=8E2023=E5=B9=B43=E6=9C=8816=E6=
=97=A5=E5=91=A8=E5=9B=9B 09:29=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Mar 14, 2023 at 03:53:45PM +0800, Song Shuai wrote:
> > The teardown of CPUHP_AP_BASE_CACHEINFO_ONLINE now only invokes
> > free_cache_attributes() to clear share_cpu_map of cacheinfo list.
> > At the same time, clearing cpu_topology[].llc_sibling is
> > called quite late at the teardown code in hotplug STARTING section.
> >
> > To avoid the incorrect LLC sibling masks generated, move its clearing
> > right after free_cache_attributes().
> >
>
> Technically in terms of flow/timing this is correct. However I would like
> to know if you are seeing any issues without this change ?
>
> Technically, if a cpu is hotplugged out, the cacheinfo is reset first
> and then the topology. Until the cpu is removes, the LLC info in the
> topology is still valid. Also I am not sure if anything gets scheduled
> and this LLC info is utilised once the teardown of CPUHP_AP_BASE_CACHEINF=
O_ONLINE
> has started.

There is no visible issue in the entire offline process(eg: echo 0 > online=
).

However, when I hotplugged out the CPU into the state before CACHEINFO_ONLI=
NE on
my kernel with the CONFIG_CPU_HOTPLUG_STATE_CONTROL configured,
the share_cpu_map had been updated but llc_sibling had not, which
would result in a trivial issue:

At the end of stepped hotplugging out, the cpuset_hotplug_work would
be flushed and then sched domain would be rebuilt
where the **cpu_coregroup_mask** in sched_domain_topology got
incorrect llc_sibling,
but the result of rebuilding was correct due to the protection of
cpu_active_mask.

The stepped hotplugging may not be used in the production environment,
but the issue existed.
Even in the entire offline process, it's possible that a future user
gets wrong the llc_sibling when accessing it concurrently or right
after the teardown of CACHEINFO_ONLINE.

>
> So I am trying to understand if we really need this change. Please let me
> know if I am missing anything here.
>
> --
> Regards,
> Sudeep



--=20
Thanks,
Song
