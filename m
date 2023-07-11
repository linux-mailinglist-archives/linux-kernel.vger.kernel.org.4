Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11D874EBD6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 12:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjGKKjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 06:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjGKKjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 06:39:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870F5E60
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 03:39:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3C9E2211C5;
        Tue, 11 Jul 2023 10:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689071975; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=44KBJ+1im2SseuOl7OurwU90VSfXsPuN6bOH+bmXMeo=;
        b=15QFgDP0OdSUp15wD7dzXcVtUkcaDFUKAcnNES6oIaMueCQa6cLRd58w86K+vVp2fsVbXU
        QJHX0+k8um8wKtzxJugLV1Hb+jNABsbH8ZGWC8SZnaCnms4ESHK84aP3s8G1hdAwr+vaGl
        BHv6v6YQxuJIujgMuiQM4ADEqUdgbxM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689071975;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=44KBJ+1im2SseuOl7OurwU90VSfXsPuN6bOH+bmXMeo=;
        b=CZrjNXKFDXgYrYygDLRtrle2FjF/Qex3slwU7zDZ5Xdu8iStTHkyJzqsBjj68JblYwAx7f
        9/z6X8qmt/DeosBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 73DB31391C;
        Tue, 11 Jul 2023 10:39:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Cgw0G2YxrWTnfwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 11 Jul 2023 10:39:34 +0000
Message-ID: <53676850-539f-2813-d55d-a8bc0ec88092@suse.cz>
Date:   Tue, 11 Jul 2023 12:39:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 00/33] Per-VMA locks
To:     Leon Romanovsky <leon@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Sachin Sant <sachinp@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        paulmck@kernel.org, mingo@redhat.com, will@kernel.org,
        luto@kernel.org, songliubraving@fb.com, peterx@redhat.com,
        david@redhat.com, dhowells@redhat.com, hughd@google.com,
        bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com, chriscli@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        gurua@google.com, arjunroy@google.com, soheil@google.com,
        leewalsh@google.com, posk@google.com,
        michalechner92@googlemail.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        regressions@leemhuis.info,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        maorg@nvidia.com, gal@nvidia.com, ranro@nvidia.com,
        drort@nvidia.com, idok@nvidia.com, sergeyy@nvidia.com
References: <20230227173632.3292573-1-surenb@google.com>
 <20230711103541.GA190975@unreal>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230711103541.GA190975@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/23 12:35, Leon Romanovsky wrote:
> 
> On Mon, Feb 27, 2023 at 09:35:59AM -0800, Suren Baghdasaryan wrote:
> 
> <...>
> 
>> Laurent Dufour (1):
>>   powerc/mm: try VMA lock-based page fault handling first
> 
> Hi,
> 
> This series and specifically the commit above broke docker over PPC.
> It causes to docker service stuck while trying to activate. Revert of
> this commit allows us to use docker again.

Hi,

there have been follow-up fixes, that are part of 6.4.3 stable (also
6.5-rc1) Does that version work for you?

Vlastimil

> [user@ppc-135-3-200-205 ~]# sudo systemctl status docker
> ● docker.service - Docker Application Container Engine
>      Loaded: loaded (/usr/lib/systemd/system/docker.service; enabled; vendor preset: disabled)
>      Active: activating (start) since Mon 2023-06-26 14:47:07 IDT; 3h 50min ago
> TriggeredBy: ● docker.socket
>        Docs: https://docs.docker.com
>    Main PID: 276555 (dockerd)
>      Memory: 44.2M
>      CGroup: /system.slice/docker.service
>              └─ 276555 /usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock
> 
> Jun 26 14:47:07 ppc-135-3-200-205 dockerd[276555]: time="2023-06-26T14:47:07.129383166+03:00" level=info msg="Graph migration to content-addressability took 0.00 se>
> Jun 26 14:47:07 ppc-135-3-200-205 dockerd[276555]: time="2023-06-26T14:47:07.129666160+03:00" level=warning msg="Your kernel does not support cgroup cfs period"
> Jun 26 14:47:07 ppc-135-3-200-205 dockerd[276555]: time="2023-06-26T14:47:07.129684117+03:00" level=warning msg="Your kernel does not support cgroup cfs quotas"
> Jun 26 14:47:07 ppc-135-3-200-205 dockerd[276555]: time="2023-06-26T14:47:07.129697085+03:00" level=warning msg="Your kernel does not support cgroup rt period"
> Jun 26 14:47:07 ppc-135-3-200-205 dockerd[276555]: time="2023-06-26T14:47:07.129711513+03:00" level=warning msg="Your kernel does not support cgroup rt runtime"
> Jun 26 14:47:07 ppc-135-3-200-205 dockerd[276555]: time="2023-06-26T14:47:07.129720656+03:00" level=warning msg="Unable to find blkio cgroup in mounts"
> Jun 26 14:47:07 ppc-135-3-200-205 dockerd[276555]: time="2023-06-26T14:47:07.129805617+03:00" level=warning msg="mountpoint for pids not found"
> Jun 26 14:47:07 ppc-135-3-200-205 dockerd[276555]: time="2023-06-26T14:47:07.130199070+03:00" level=info msg="Loading containers: start."
> Jun 26 14:47:07 ppc-135-3-200-205 dockerd[276555]: time="2023-06-26T14:47:07.132688568+03:00" level=warning msg="Running modprobe bridge br_netfilter failed with me>
> Jun 26 14:47:07 ppc-135-3-200-205 dockerd[276555]: time="2023-06-26T14:47:07.271014050+03:00" level=info msg="Default bridge (docker0) is assigned with an IP addres>
> 
> Python script which we used for bisect:
> 
> import subprocess
> import time
> import sys
> 
> 
> def run_command(cmd):
>     print('running:', cmd)
> 
>     p = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
> 
>     try:
>         stdout, stderr = p.communicate(timeout=30)
> 
>     except subprocess.TimeoutExpired:
>         return True
> 
>     print(stdout.decode())
>     print(stderr.decode())
>     print('rc:', p.returncode)
> 
>     return False
> 
> 
> def main():
>     commands = [
>         'sudo systemctl stop docker',
>         'sudo systemctl status docker',
>         'sudo systemctl is-active docker',
>         'sudo systemctl start docker',
>         'sudo systemctl status docker',
>     ]
> 
>     for i in range(1000):
>         title = f'Try no. {i + 1}'
>         print('*' * 50, title, '*' * 50)
> 
>         for cmd in commands:
>             if run_command(cmd):
>                 print(f'Reproduced on try no. {i + 1}!')
>                 print(f'"{cmd}" is stuck!')
> 
>                 return 1
> 
>             print('\n')
>         time.sleep(30)
>     return 0
> 
> if __name__ == '__main__':
>     sys.exit(main())
> 
> Thanks

