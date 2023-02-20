Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF8169C623
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 08:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjBTHvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 02:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjBTHvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 02:51:45 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132EDD507
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 23:51:43 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id m7so530356lfj.8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 23:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dqzwdfvYoqq0dEPHyvWAuytY+Vb3iU2zbeOBZll8Tq0=;
        b=n3DmFbNyDwrRqWz/rgHXvJkS92ro8np94H73NPKC0bnO5cqWbHfUWq9mR5pcDjm2Fz
         WPXk/zH01UMruXFt383yCsC8OON8xPDQQ5vfN2V1Zno9vlqWTQyvg+zh2H3B0AOjYwEW
         T9DNVoLQPXH00UrJOE/tCRTBnhdULx1C9FYmo3VqhdMM5QOVVr/0hcZeEKKu+0S7iOG1
         wlGBduYNhORZTjm0sDH8/aBm5ItJzQcfc/Pc4YgeVx0BLbTifxsOl2QznhwN6mo3dPbQ
         cFLX4wmv5ZaoECs+PweV1do58TbF/Mb4VGqfCbKHGJxKcxPuevP20jgdHSme0AW9OLJ6
         rB5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dqzwdfvYoqq0dEPHyvWAuytY+Vb3iU2zbeOBZll8Tq0=;
        b=BP+nSa83VzXCCjnAOONEqQwBX2UZ6Ynt//E5R9yHi+Tx3lwA+YsIdj7XRD3Ztme+Ms
         vZnxgrRUQpdioUSTJB8HZtLl03t057G9Qb8h83F/u6cDuFCbnX/CbAWb72IGzZaHh5zH
         xOkscOuSw6d9eUpZwTtnDJzkL2isY6KapwMCj8spGe3cviqeHG9Bb/aH9WUXUIu4QQ2H
         bpPj2JuFp5RcRkNlvr2+CSUenhaZl6N3Ssv3E2e9e1Iu/Gjf7oK+Hdlq+Vc2VL6Jo/Ez
         MdX/rE+4BtgkFP+/EfrwBoEG90BN0sJJuyZhvfGcwb7p586pXceKbkGLlwbYZ3JaEBuG
         ZjGw==
X-Gm-Message-State: AO0yUKVIs0U5b5KOMIcFZVSTlSS8HqDv8IKWyNlEs/QW7gR+cuXiMaAE
        sSbIgYOALJqtZUBoy39Tk8jcmkBOk1j4FfR6QdKRfg==
X-Google-Smtp-Source: AK7set9qR9y+RugbJHVXalSwYhtBarJSucskDrYkDMpTn0kjAKaKKu/24Pz3npQ6wUEbZ2d0c8SGeveTNt1EmN5m/Zg=
X-Received: by 2002:a19:ac41:0:b0:4db:1a0d:f261 with SMTP id
 r1-20020a19ac41000000b004db1a0df261mr254373lfc.3.1676879501097; Sun, 19 Feb
 2023 23:51:41 -0800 (PST)
MIME-Version: 1.0
References: <20230220072531.2352-1-hdanton@sina.com> <00000000000074a5d005f51cc69c@google.com>
In-Reply-To: <00000000000074a5d005f51cc69c@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 20 Feb 2023 08:51:28 +0100
Message-ID: <CACT4Y+bQaAB5Z0J2=GV7MepYs6gRopMw-qGRSv7ufMe9xQ5Z6w@mail.gmail.com>
Subject: Re: [syzbot] [bridge?] [netfilter?] KASAN: vmalloc-out-of-bounds Read
 in __ebt_unregister_table
To:     hdanton@sina.com
Cc:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+f61594de72d6705aea03@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hillf,

I see that Florian also tested a fix for this:
https://syzkaller.appspot.com/bug?extid=3Df61594de72d6705aea03
It looks like Florian figured out something about this bug.


On Mon, 20 Feb 2023 at 08:40, syzbot
<syzbot+f61594de72d6705aea03@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot tried to test the proposed patch but the build/boot failed:
>
> BUG: program execution failed: executor NUM: exit status NUM
>
> executing program
> 2023/02/20 07:39:21 SYZFATAL: BUG: program execution failed: executor 0: =
exit status 67
> SYZFAIL: ebtable checkpoint: getsockopt(EBT_SO_GET_INIT_INFO) failed
> table=3Dbroute (errno 22: Invalid argument)
> loop exited with status 67
>
> SYZFAIL: ebtable checkpoint: getsockopt(EBT_SO_GET_INIT_INFO) failed
> table=3Dbroute (errno 22: Invalid argument)
> loop exited with status 67
>
>
> forked to background, child pid 4644
> no interfaces have a carri[   21.644085][ T4645] 8021q: adding VLAN 0 to =
HW filter on device bond0
> er
> [   21.654665][ T4645] eql: remember to turn off Van-Jacobson compression=
 on your slave devices
> Starting sshd: OK
>
> syzkaller
> Warning: Permanently added '10.128.1.147' (ECDSA) to the list of known ho=
sts.
> 2023/02/20 07:39:16 fuzzer started
> 2023/02/20 07:39:16 connecting to host at 10.128.0.169:38103
> 2023/02/20 07:39:16 checking machine...
> 2023/02/20 07:39:16 checking revisions...
> 2023/02/20 07:39:16 testing simple program...
> syzkaller login: [   41.158159][ T5072] cgroup: Unknown subsys name 'net'
> [   41.280558][ T5072] cgroup: Unknown subsys name 'rlimit'
> [   41.458767][   T47] Bluetooth: hci0: unexpected cc 0x0c03 length: 249 =
> 1
> [   41.466801][   T47] Bluetooth: hci0: unexpected cc 0x1003 length: 249 =
> 9
> [   41.474302][   T47] Bluetooth: hci0: unexpected cc 0x1001 length: 249 =
> 9
> [   41.482242][   T47] Bluetooth: hci0: unexpected cc 0x0c23 length: 249 =
> 4
> [   41.489962][   T47] Bluetooth: hci0: unexpected cc 0x0c25 length: 249 =
> 3
> [   41.497314][   T47] Bluetooth: hci0: unexpected cc 0x0c38 length: 249 =
> 2
> [   41.575513][ T5074] chnl_net:caif_netlink_parms(): no params data foun=
d
> [   41.605498][ T5074] bridge0: port 1(bridge_slave_0) entered blocking s=
tate
> [   41.612704][ T5074] bridge0: port 1(bridge_slave_0) entered disabled s=
tate
> [   41.621073][ T5074] device bridge_slave_0 entered promiscuous mode
> [   41.629011][ T5074] bridge0: port 2(bridge_slave_1) entered blocking s=
tate
> [   41.636311][ T5074] bridge0: port 2(bridge_slave_1) entered disabled s=
tate
> [   41.644219][ T5074] device bridge_slave_1 entered promiscuous mode
> [   41.660216][ T5074] bond0: (slave bond_slave_0): Enslaving as an activ=
e interface with an up link
> [   41.670509][ T5074] bond0: (slave bond_slave_1): Enslaving as an activ=
e interface with an up link
> [   41.687969][ T5074] team0: Port device team_slave_0 added
> [   41.694592][ T5074] team0: Port device team_slave_1 added
> [   41.707841][ T5074] batman_adv: batadv0: Adding interface: batadv_slav=
e_0
> [   41.714774][ T5074] batman_adv: batadv0: The MTU of interface batadv_s=
lave_0 is too small (1500) to handle the transport of batman-adv packets. P=
ackets going over this interface will be fragmented on layer2 which could i=
mpact the performance. Setting the MTU to 1560 would solve the problem.
> [   41.740979][ T5074] batman_adv: batadv0: Not using interface batadv_sl=
ave_0 (retrying later): interface not active
> [   41.753328][ T5074] batman_adv: batadv0: Adding interface: batadv_slav=
e_1
> [   41.760417][ T5074] batman_adv: batadv0: The MTU of interface batadv_s=
lave_1 is too small (1500) to handle the transport of batman-adv packets. P=
ackets going over this interface will be fragmented on layer2 which could i=
mpact the performance. Setting the MTU to 1560 would solve the problem.
> [   41.786578][ T5074] batman_adv: batadv0: Not using interface batadv_sl=
ave_1 (retrying later): interface not active
> [   41.808751][ T5074] device hsr_slave_0 entered promiscuous mode
> [   41.815328][ T5074] device hsr_slave_1 entered promiscuous mode
> [   41.868811][ T5074] netdevsim netdevsim0 netdevsim0: renamed from eth0
> [   41.878202][ T5074] netdevsim netdevsim0 netdevsim1: renamed from eth1
> [   41.886794][ T5074] netdevsim netdevsim0 netdevsim2: renamed from eth2
> [   41.894950][ T5074] netdevsim netdevsim0 netdevsim3: renamed from eth3
> [   41.910541][ T5074] bridge0: port 2(bridge_slave_1) entered blocking s=
tate
> [   41.917682][ T5074] bridge0: port 2(bridge_slave_1) entered forwarding=
 state
> [   41.925140][ T5074] bridge0: port 1(bridge_slave_0) entered blocking s=
tate
> [   41.932231][ T5074] bridge0: port 1(bridge_slave_0) entered forwarding=
 state
> [   41.961982][ T5074] 8021q: adding VLAN 0 to HW filter on device bond0
> [   41.975137][ T5074] 8021q: adding VLAN 0 to HW filter on device team0
> [   41.982463][ T5085] IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes=
 ready
> [   41.991359][ T5085] bridge0: port 1(bridge_slave_0) entered disabled s=
tate
> [   41.999460][ T5085] bridge0: port 2(bridge_slave_1) entered disabled s=
tate
> [   42.007256][ T5085] IPv6: ADDRCONF(NETDEV_CHANGE): bond0: link becomes=
 ready
> [   42.019018][   T22] IPv6: ADDRCONF(NETDEV_CHANGE): bridge_slave_0: lin=
k becomes ready
> [   42.027409][   T22] bridge0: port 1(bridge_slave_0) entered blocking s=
tate
> [   42.034725][   T22] bridge0: port 1(bridge_slave_0) entered forwarding=
 state
> [   42.057701][   T22] IPv6: ADDRCONF(NETDEV_CHANGE): bridge_slave_1: lin=
k becomes ready
> [   42.066041][   T22] bridge0: port 2(bridge_slave_1) entered blocking s=
tate
> [   42.073143][   T22] bridge0: port 2(bridge_slave_1) entered forwarding=
 state
> [   42.081105][   T22] IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_0: link =
becomes ready
> [   42.089690][   T22] IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_1: link =
becomes ready
> [   42.097954][   T22] IPv6: ADDRCONF(NETDEV_CHANGE): hsr_slave_0: link b=
ecomes ready
> [   42.105963][   T22] IPv6: ADDRCONF(NETDEV_CHANGE): hsr_slave_1: link b=
ecomes ready
> [   42.114939][   T22] IPv6: ADDRCONF(NETDEV_CHANGE): team0: link becomes=
 ready
> [   42.124330][ T5074] IPv6: ADDRCONF(NETDEV_CHANGE): hsr0: link becomes =
ready
> [   42.210712][ T5074] 8021q: adding VLAN 0 to HW filter on device batadv=
0
> [   42.218113][ T5085] IPv6: ADDRCONF(NETDEV_CHANGE): vxcan0: link become=
s ready
> [   42.225438][ T5085] IPv6: ADDRCONF(NETDEV_CHANGE): vxcan1: link become=
s ready
> [   42.239448][   T22] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_virt_wifi: li=
nk becomes ready
> [   42.253747][ T5074] device veth0_vlan entered promiscuous mode
> [   42.260990][ T5086] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_vlan: link be=
comes ready
> [   42.269189][ T5086] IPv6: ADDRCONF(NETDEV_CHANGE): vlan0: link becomes=
 ready
> [   42.277611][ T5086] IPv6: ADDRCONF(NETDEV_CHANGE): vlan1: link becomes=
 ready
> [   42.287989][ T5074] device veth1_vlan entered promiscuous mode
> [   42.301815][ T5086] IPv6: ADDRCONF(NETDEV_CHANGE): macvlan0: link beco=
mes ready
> [   42.309984][ T5086] IPv6: ADDRCONF(NETDEV_CHANGE): macvlan1: link beco=
mes ready
> [   42.318401][ T5086] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_macvtap: link=
 becomes ready
> [   42.329281][ T5074] device veth0_macvtap entered promiscuous mode
> [   42.338518][ T5074] device veth1_macvtap entered promiscuous mode
> [   42.350723][ T5074] batman_adv: batadv0: Interface activated: batadv_s=
lave_0
> [   42.358825][ T5085] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_batadv: li=
nk becomes ready
> [   42.368262][ T5085] IPv6: ADDRCONF(NETDEV_CHANGE): macvtap0: link beco=
mes ready
> [   42.378872][ T5074] batman_adv: batadv0: Interface activated: batadv_s=
lave_1
> [   42.386287][ T5086] IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_batadv: li=
nk becomes ready
> [   42.396632][ T5074] netdevsim netdevsim0 netdevsim0: set [1, 0] type 2=
 family 0 port 6081 - 0
> [   42.405419][ T5074] netdevsim netdevsim0 netdevsim1: set [1, 0] type 2=
 family 0 port 6081 - 0
> [   42.414360][ T5074] netdevsim netdevsim0 netdevsim2: set [1, 0] type 2=
 family 0 port 6081 - 0
> [   42.423211][ T5074] netdevsim netdevsim0 netdevsim3: set [1, 0] type 2=
 family 0 port 6081 - 0
> [   42.463113][   T55] wlan0: Created IBSS using preconfigured BSSID 50:5=
0:50:50:50:50
> [   42.471160][   T55] wlan0: Creating new IBSS network, BSSID 50:50:50:5=
0:50:50
> [   42.482258][ T5085] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes=
 ready
> [   42.491386][   T55] wlan1: Created IBSS using preconfigured BSSID 50:5=
0:50:50:50:50
> [   42.499597][   T55] wlan1: Creating new IBSS network, BSSID 50:50:50:5=
0:50:50
> [   42.507812][ T5085] IPv6: ADDRCONF(NETDEV_CHANGE): wlan1: link becomes=
 ready
> executing program
> 2023/02/20 07:39:21 SYZFATAL: BUG: program execution failed: executor 0: =
exit status 67
> SYZFAIL: ebtable checkpoint: getsockopt(EBT_SO_GET_INIT_INFO) failed
> table=3Dbroute (errno 22: Invalid argument)
> loop exited with status 67
>
> SYZFAIL: ebtable checkpoint: getsockopt(EBT_SO_GET_INIT_INFO) failed
> table=3Dbroute (errno 22: Invalid argument)
> loop exited with status 67
> [   46.245969][ T3557] netdevsim netdevsim0 netdevsim3 (unregistering): u=
nset [1, 0] type 2 family 0 port 6081 - 0
>
>
> syzkaller build log:
> go env (err=3D<nil>)
> GO111MODULE=3D"auto"
> GOARCH=3D"amd64"
> GOBIN=3D""
> GOCACHE=3D"/syzkaller/.cache/go-build"
> GOENV=3D"/syzkaller/.config/go/env"
> GOEXE=3D""
> GOEXPERIMENT=3D""
> GOFLAGS=3D""
> GOHOSTARCH=3D"amd64"
> GOHOSTOS=3D"linux"
> GOINSECURE=3D""
> GOMODCACHE=3D"/syzkaller/jobs/linux/gopath/pkg/mod"
> GONOPROXY=3D""
> GONOSUMDB=3D""
> GOOS=3D"linux"
> GOPATH=3D"/syzkaller/jobs/linux/gopath"
> GOPRIVATE=3D""
> GOPROXY=3D"https://proxy.golang.org,direct"
> GOROOT=3D"/usr/local/go"
> GOSUMDB=3D"sum.golang.org"
> GOTMPDIR=3D""
> GOTOOLDIR=3D"/usr/local/go/pkg/tool/linux_amd64"
> GOVCS=3D""
> GOVERSION=3D"go1.17"
> GCCGO=3D"gccgo"
> AR=3D"ar"
> CC=3D"gcc"
> CXX=3D"g++"
> CGO_ENABLED=3D"1"
> GOMOD=3D"/syzkaller/jobs/linux/gopath/src/github.com/google/syzkaller/go.=
mod"
> CGO_CFLAGS=3D"-g -O2"
> CGO_CPPFLAGS=3D""
> CGO_CXXFLAGS=3D"-g -O2"
> CGO_FFLAGS=3D"-g -O2"
> CGO_LDFLAGS=3D"-g -O2"
> PKG_CONFIG=3D"pkg-config"
> GOGCCFLAGS=3D"-fPIC -m64 -pthread -fmessage-length=3D0 -fdebug-prefix-map=
=3D/tmp/go-build2682014572=3D/tmp/go-build -gno-record-gcc-switches"
>
> git status (err=3D<nil>)
> HEAD detached at 851bc19a3
> nothing to commit, working tree clean
>
>
> tput: No value for $TERM and no -T specified
> tput: No value for $TERM and no -T specified
> Makefile:32: run command via tools/syz-env for best compatibility, see:
> Makefile:33: https://github.com/google/syzkaller/blob/master/docs/contrib=
uting.md#using-syz-env
> go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./=
sys/syz-sysgen
> make .descriptions
> tput: No value for $TERM and no -T specified
> tput: No value for $TERM and no -T specified
> bin/syz-sysgen
> touch .descriptions
> GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/goog=
le/syzkaller/prog.GitRevision=3D851bc19a3c4615f6653414b6deec9b9e84c8ca58 -X=
 'github.com/google/syzkaller/prog.gitRevisionDate=3D20230216-173454'" "-ta=
gs=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzz=
er github.com/google/syzkaller/syz-fuzzer
> GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/goog=
le/syzkaller/prog.GitRevision=3D851bc19a3c4615f6653414b6deec9b9e84c8ca58 -X=
 'github.com/google/syzkaller/prog.gitRevisionDate=3D20230216-173454'" "-ta=
gs=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-exec=
prog github.com/google/syzkaller/tools/syz-execprog
> GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/goog=
le/syzkaller/prog.GitRevision=3D851bc19a3c4615f6653414b6deec9b9e84c8ca58 -X=
 'github.com/google/syzkaller/prog.gitRevisionDate=3D20230216-173454'" "-ta=
gs=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stre=
ss github.com/google/syzkaller/tools/syz-stress
> mkdir -p ./bin/linux_amd64
> gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
>         -m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-vari=
able -Wframe-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -=
Wno-format-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-a=
rgument -static-pie -fpermissive -w -DGOOS_linux=3D1 -DGOARCH_amd64=3D1 \
>         -DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"851bc19a3c4615f6653414b6d=
eec9b9e84c8ca58\"
>
>
>
> Tested on:
>
> commit:         3ac88fa4 Merge tag 'net-6.2-final' of git://git.kernel..
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/=
linux.git
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dfe56f7d193926=
860
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Df61594de72d6705=
aea03
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binuti=
ls for Debian) 2.35.2
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D17c96c30c8=
0000
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/00000000000074a5d005f51cc69c%40google.com.
