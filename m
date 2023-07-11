Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8621074EBCD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 12:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjGKKfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 06:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjGKKfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 06:35:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251021A2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 03:35:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADDE861467
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 10:35:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 400C3C433C8;
        Tue, 11 Jul 2023 10:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689071746;
        bh=RdirUcCE2pA/1z8207uTNCXjhMGAcU2jC5JA2KzMRoY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b1nsnyWJfs1mcjVYHJe+HEUCi0LN15hY99BnaXhtfz0oB3h8EzQMDa9aeEPB4cHsG
         m0hzpx+fMmsE8WzKuxURAUSYoPOk1yyNeGjKmk6Oo1T+sxizOWkbUk2lnWZeZJq/OR
         t35F+euEtnNr2grYlFD6oJ2MJWvp/QNNOG1DuAJeBI5VAMb7y9WA/nlkd3eUTkr2Lb
         BRvBfq7P9mdE+wM/H6F8uotrR4TMskih7C1j7iuXPsrtoxNhX7cAuYqxh5Z1V2YE+p
         NfC0fI8jKAJTifgfTIIMFJicOPaZ5ZezvtKLTLYQgP5kZnonqVF+tNhSPdx4zGnzF9
         S3WTHtdee7iTg==
Date:   Tue, 11 Jul 2023 13:35:41 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Suren Baghdasaryan <surenb@google.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Sachin Sant <sachinp@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com, paulmck@kernel.org,
        mingo@redhat.com, will@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, peterjung1337@gmail.com, rientjes@google.com,
        chriscli@google.com, axelrasmussen@google.com, joelaf@google.com,
        minchan@google.com, rppt@kernel.org, jannh@google.com,
        shakeelb@google.com, tatashin@google.com, edumazet@google.com,
        gthelen@google.com, gurua@google.com, arjunroy@google.com,
        soheil@google.com, leewalsh@google.com, posk@google.com,
        michalechner92@googlemail.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        regressions@leemhuis.info,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        maorg@nvidia.com, gal@nvidia.com, ranro@nvidia.com,
        drort@nvidia.com, idok@nvidia.com, sergeyy@nvidia.com
Subject: Re: [PATCH v4 00/33] Per-VMA locks
Message-ID: <20230711103541.GA190975@unreal>
References: <20230227173632.3292573-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230227173632.3292573-1-surenb@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, Feb 27, 2023 at 09:35:59AM -0800, Suren Baghdasaryan wrote:

<...>

> Laurent Dufour (1):
>   powerc/mm: try VMA lock-based page fault handling first

Hi,

This series and specifically the commit above broke docker over PPC.
It causes to docker service stuck while trying to activate. Revert of
this commit allows us to use docker again.

[user@ppc-135-3-200-205 ~]# sudo systemctl status docker
=E2=97=8F docker.service - Docker Application Container Engine
     Loaded: loaded (/usr/lib/systemd/system/docker.service; enabled; vendo=
r preset: disabled)
     Active: activating (start) since Mon 2023-06-26 14:47:07 IDT; 3h 50min=
 ago
TriggeredBy: =E2=97=8F docker.socket
       Docs: https://docs.docker.com
   Main PID: 276555 (dockerd)
     Memory: 44.2M
     CGroup: /system.slice/docker.service
             =E2=94=94=E2=94=80 276555 /usr/bin/dockerd -H fd:// --containe=
rd=3D/run/containerd/containerd.sock

Jun 26 14:47:07 ppc-135-3-200-205 dockerd[276555]: time=3D"2023-06-26T14:47=
:07.129383166+03:00" level=3Dinfo msg=3D"Graph migration to content-address=
ability took 0.00 se>
Jun 26 14:47:07 ppc-135-3-200-205 dockerd[276555]: time=3D"2023-06-26T14:47=
:07.129666160+03:00" level=3Dwarning msg=3D"Your kernel does not support cg=
roup cfs period"
Jun 26 14:47:07 ppc-135-3-200-205 dockerd[276555]: time=3D"2023-06-26T14:47=
:07.129684117+03:00" level=3Dwarning msg=3D"Your kernel does not support cg=
roup cfs quotas"
Jun 26 14:47:07 ppc-135-3-200-205 dockerd[276555]: time=3D"2023-06-26T14:47=
:07.129697085+03:00" level=3Dwarning msg=3D"Your kernel does not support cg=
roup rt period"
Jun 26 14:47:07 ppc-135-3-200-205 dockerd[276555]: time=3D"2023-06-26T14:47=
:07.129711513+03:00" level=3Dwarning msg=3D"Your kernel does not support cg=
roup rt runtime"
Jun 26 14:47:07 ppc-135-3-200-205 dockerd[276555]: time=3D"2023-06-26T14:47=
:07.129720656+03:00" level=3Dwarning msg=3D"Unable to find blkio cgroup in =
mounts"
Jun 26 14:47:07 ppc-135-3-200-205 dockerd[276555]: time=3D"2023-06-26T14:47=
:07.129805617+03:00" level=3Dwarning msg=3D"mountpoint for pids not found"
Jun 26 14:47:07 ppc-135-3-200-205 dockerd[276555]: time=3D"2023-06-26T14:47=
:07.130199070+03:00" level=3Dinfo msg=3D"Loading containers: start."
Jun 26 14:47:07 ppc-135-3-200-205 dockerd[276555]: time=3D"2023-06-26T14:47=
:07.132688568+03:00" level=3Dwarning msg=3D"Running modprobe bridge br_netf=
ilter failed with me>
Jun 26 14:47:07 ppc-135-3-200-205 dockerd[276555]: time=3D"2023-06-26T14:47=
:07.271014050+03:00" level=3Dinfo msg=3D"Default bridge (docker0) is assign=
ed with an IP addres>

Python script which we used for bisect:

import subprocess
import time
import sys


def run_command(cmd):
    print('running:', cmd)

    p =3D subprocess.Popen(cmd, shell=3DTrue, stdout=3Dsubprocess.PIPE, std=
err=3Dsubprocess.PIPE)

    try:
        stdout, stderr =3D p.communicate(timeout=3D30)

    except subprocess.TimeoutExpired:
        return True

    print(stdout.decode())
    print(stderr.decode())
    print('rc:', p.returncode)

    return False


def main():
    commands =3D [
        'sudo systemctl stop docker',
        'sudo systemctl status docker',
        'sudo systemctl is-active docker',
        'sudo systemctl start docker',
        'sudo systemctl status docker',
    ]

    for i in range(1000):
        title =3D f'Try no. {i + 1}'
        print('*' * 50, title, '*' * 50)

        for cmd in commands:
            if run_command(cmd):
                print(f'Reproduced on try no. {i + 1}!')
                print(f'"{cmd}" is stuck!')

                return 1

            print('\n')
        time.sleep(30)
    return 0

if __name__ =3D=3D '__main__':
    sys.exit(main())

Thanks
