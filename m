Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4E869C613
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 08:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjBTHkf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 20 Feb 2023 02:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjBTHkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 02:40:23 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5A311143
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 23:40:21 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id y5-20020a6bc405000000b007132e024fb5so1263463ioa.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 23:40:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nCPEbMRsKwWLaKLnoPmBRfnMF5XuErOEY5wo+mUQ/bU=;
        b=2Jnkc/SyQnJ39SVZlihB0BicqssvhjZStZlmbJTWWdzD6rutpT6OJGxDedRaDjqXxh
         poae2cIHhOgCsq/mH4h8JCjEVO5fSJWYo4JDl56Nt7x8MgTf4kMeuIrJx8niwtYepvIc
         LJag3/oH/g2C56lobOA3GbkzW4RSMhhxg9Hm09IpUjIT6b7qOLC4Kqh//pGXbgcaS2uO
         t2ujFaGkHWUUdVv3JNi40Jn0AQw26xYP+Iy+m6nidCXYYlCv7I1orS6T9vxsqhCVHu8c
         2dGW4dTANNvPW2JsrTL7PIzVUBpgIFA4TfeDfdz/5V2dY422ewDULxYAIeytD5O/4m8q
         rYLQ==
X-Gm-Message-State: AO0yUKXAEYLCBt21oHtuYsLT+luT2EfrnWhwuTl2/ovMgiPs47tOPV7J
        uZoEuK0NWNp8WqSjxu1pLMX/1u//KJmPR2g0CPaTv8qz8Jd5
X-Google-Smtp-Source: AK7set894KUqCo7IKe8CBGAZdEW9sDsKIMRkmcaxiELfNHyS0E3hTgti1l14zUbIljTEitXL0xU672Zix6dJMRIh7g4iDS2Xe+vw
MIME-Version: 1.0
X-Received: by 2002:a02:2289:0:b0:3c4:d689:968d with SMTP id
 o131-20020a022289000000b003c4d689968dmr619288jao.1.1676878820974; Sun, 19 Feb
 2023 23:40:20 -0800 (PST)
Date:   Sun, 19 Feb 2023 23:40:20 -0800
In-Reply-To: <20230220072531.2352-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000074a5d005f51cc69c@google.com>
Subject: Re: [syzbot] [bridge?] [netfilter?] KASAN: vmalloc-out-of-bounds Read
 in __ebt_unregister_table
From:   syzbot <syzbot+f61594de72d6705aea03@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

BUG: program execution failed: executor NUM: exit status NUM

executing program
2023/02/20 07:39:21 SYZFATAL: BUG: program execution failed: executor 0: exit status 67
SYZFAIL: ebtable checkpoint: getsockopt(EBT_SO_GET_INIT_INFO) failed
table=broute (errno 22: Invalid argument)
loop exited with status 67

SYZFAIL: ebtable checkpoint: getsockopt(EBT_SO_GET_INIT_INFO) failed
table=broute (errno 22: Invalid argument)
loop exited with status 67


forked to background, child pid 4644
no interfaces have a carri[   21.644085][ T4645] 8021q: adding VLAN 0 to HW filter on device bond0
er
[   21.654665][ T4645] eql: remember to turn off Van-Jacobson compression on your slave devices
Starting sshd: OK

syzkaller
Warning: Permanently added '10.128.1.147' (ECDSA) to the list of known hosts.
2023/02/20 07:39:16 fuzzer started
2023/02/20 07:39:16 connecting to host at 10.128.0.169:38103
2023/02/20 07:39:16 checking machine...
2023/02/20 07:39:16 checking revisions...
2023/02/20 07:39:16 testing simple program...
syzkaller login: [   41.158159][ T5072] cgroup: Unknown subsys name 'net'
[   41.280558][ T5072] cgroup: Unknown subsys name 'rlimit'
[   41.458767][   T47] Bluetooth: hci0: unexpected cc 0x0c03 length: 249 > 1
[   41.466801][   T47] Bluetooth: hci0: unexpected cc 0x1003 length: 249 > 9
[   41.474302][   T47] Bluetooth: hci0: unexpected cc 0x1001 length: 249 > 9
[   41.482242][   T47] Bluetooth: hci0: unexpected cc 0x0c23 length: 249 > 4
[   41.489962][   T47] Bluetooth: hci0: unexpected cc 0x0c25 length: 249 > 3
[   41.497314][   T47] Bluetooth: hci0: unexpected cc 0x0c38 length: 249 > 2
[   41.575513][ T5074] chnl_net:caif_netlink_parms(): no params data found
[   41.605498][ T5074] bridge0: port 1(bridge_slave_0) entered blocking state
[   41.612704][ T5074] bridge0: port 1(bridge_slave_0) entered disabled state
[   41.621073][ T5074] device bridge_slave_0 entered promiscuous mode
[   41.629011][ T5074] bridge0: port 2(bridge_slave_1) entered blocking state
[   41.636311][ T5074] bridge0: port 2(bridge_slave_1) entered disabled state
[   41.644219][ T5074] device bridge_slave_1 entered promiscuous mode
[   41.660216][ T5074] bond0: (slave bond_slave_0): Enslaving as an active interface with an up link
[   41.670509][ T5074] bond0: (slave bond_slave_1): Enslaving as an active interface with an up link
[   41.687969][ T5074] team0: Port device team_slave_0 added
[   41.694592][ T5074] team0: Port device team_slave_1 added
[   41.707841][ T5074] batman_adv: batadv0: Adding interface: batadv_slave_0
[   41.714774][ T5074] batman_adv: batadv0: The MTU of interface batadv_slave_0 is too small (1500) to handle the transport of batman-adv packets. Packets going over this interface will be fragmented on layer2 which could impact the performance. Setting the MTU to 1560 would solve the problem.
[   41.740979][ T5074] batman_adv: batadv0: Not using interface batadv_slave_0 (retrying later): interface not active
[   41.753328][ T5074] batman_adv: batadv0: Adding interface: batadv_slave_1
[   41.760417][ T5074] batman_adv: batadv0: The MTU of interface batadv_slave_1 is too small (1500) to handle the transport of batman-adv packets. Packets going over this interface will be fragmented on layer2 which could impact the performance. Setting the MTU to 1560 would solve the problem.
[   41.786578][ T5074] batman_adv: batadv0: Not using interface batadv_slave_1 (retrying later): interface not active
[   41.808751][ T5074] device hsr_slave_0 entered promiscuous mode
[   41.815328][ T5074] device hsr_slave_1 entered promiscuous mode
[   41.868811][ T5074] netdevsim netdevsim0 netdevsim0: renamed from eth0
[   41.878202][ T5074] netdevsim netdevsim0 netdevsim1: renamed from eth1
[   41.886794][ T5074] netdevsim netdevsim0 netdevsim2: renamed from eth2
[   41.894950][ T5074] netdevsim netdevsim0 netdevsim3: renamed from eth3
[   41.910541][ T5074] bridge0: port 2(bridge_slave_1) entered blocking state
[   41.917682][ T5074] bridge0: port 2(bridge_slave_1) entered forwarding state
[   41.925140][ T5074] bridge0: port 1(bridge_slave_0) entered blocking state
[   41.932231][ T5074] bridge0: port 1(bridge_slave_0) entered forwarding state
[   41.961982][ T5074] 8021q: adding VLAN 0 to HW filter on device bond0
[   41.975137][ T5074] 8021q: adding VLAN 0 to HW filter on device team0
[   41.982463][ T5085] IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
[   41.991359][ T5085] bridge0: port 1(bridge_slave_0) entered disabled state
[   41.999460][ T5085] bridge0: port 2(bridge_slave_1) entered disabled state
[   42.007256][ T5085] IPv6: ADDRCONF(NETDEV_CHANGE): bond0: link becomes ready
[   42.019018][   T22] IPv6: ADDRCONF(NETDEV_CHANGE): bridge_slave_0: link becomes ready
[   42.027409][   T22] bridge0: port 1(bridge_slave_0) entered blocking state
[   42.034725][   T22] bridge0: port 1(bridge_slave_0) entered forwarding state
[   42.057701][   T22] IPv6: ADDRCONF(NETDEV_CHANGE): bridge_slave_1: link becomes ready
[   42.066041][   T22] bridge0: port 2(bridge_slave_1) entered blocking state
[   42.073143][   T22] bridge0: port 2(bridge_slave_1) entered forwarding state
[   42.081105][   T22] IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_0: link becomes ready
[   42.089690][   T22] IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_1: link becomes ready
[   42.097954][   T22] IPv6: ADDRCONF(NETDEV_CHANGE): hsr_slave_0: link becomes ready
[   42.105963][   T22] IPv6: ADDRCONF(NETDEV_CHANGE): hsr_slave_1: link becomes ready
[   42.114939][   T22] IPv6: ADDRCONF(NETDEV_CHANGE): team0: link becomes ready
[   42.124330][ T5074] IPv6: ADDRCONF(NETDEV_CHANGE): hsr0: link becomes ready
[   42.210712][ T5074] 8021q: adding VLAN 0 to HW filter on device batadv0
[   42.218113][ T5085] IPv6: ADDRCONF(NETDEV_CHANGE): vxcan0: link becomes ready
[   42.225438][ T5085] IPv6: ADDRCONF(NETDEV_CHANGE): vxcan1: link becomes ready
[   42.239448][   T22] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_virt_wifi: link becomes ready
[   42.253747][ T5074] device veth0_vlan entered promiscuous mode
[   42.260990][ T5086] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_vlan: link becomes ready
[   42.269189][ T5086] IPv6: ADDRCONF(NETDEV_CHANGE): vlan0: link becomes ready
[   42.277611][ T5086] IPv6: ADDRCONF(NETDEV_CHANGE): vlan1: link becomes ready
[   42.287989][ T5074] device veth1_vlan entered promiscuous mode
[   42.301815][ T5086] IPv6: ADDRCONF(NETDEV_CHANGE): macvlan0: link becomes ready
[   42.309984][ T5086] IPv6: ADDRCONF(NETDEV_CHANGE): macvlan1: link becomes ready
[   42.318401][ T5086] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_macvtap: link becomes ready
[   42.329281][ T5074] device veth0_macvtap entered promiscuous mode
[   42.338518][ T5074] device veth1_macvtap entered promiscuous mode
[   42.350723][ T5074] batman_adv: batadv0: Interface activated: batadv_slave_0
[   42.358825][ T5085] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_batadv: link becomes ready
[   42.368262][ T5085] IPv6: ADDRCONF(NETDEV_CHANGE): macvtap0: link becomes ready
[   42.378872][ T5074] batman_adv: batadv0: Interface activated: batadv_slave_1
[   42.386287][ T5086] IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_batadv: link becomes ready
[   42.396632][ T5074] netdevsim netdevsim0 netdevsim0: set [1, 0] type 2 family 0 port 6081 - 0
[   42.405419][ T5074] netdevsim netdevsim0 netdevsim1: set [1, 0] type 2 family 0 port 6081 - 0
[   42.414360][ T5074] netdevsim netdevsim0 netdevsim2: set [1, 0] type 2 family 0 port 6081 - 0
[   42.423211][ T5074] netdevsim netdevsim0 netdevsim3: set [1, 0] type 2 family 0 port 6081 - 0
[   42.463113][   T55] wlan0: Created IBSS using preconfigured BSSID 50:50:50:50:50:50
[   42.471160][   T55] wlan0: Creating new IBSS network, BSSID 50:50:50:50:50:50
[   42.482258][ T5085] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
[   42.491386][   T55] wlan1: Created IBSS using preconfigured BSSID 50:50:50:50:50:50
[   42.499597][   T55] wlan1: Creating new IBSS network, BSSID 50:50:50:50:50:50
[   42.507812][ T5085] IPv6: ADDRCONF(NETDEV_CHANGE): wlan1: link becomes ready
executing program
2023/02/20 07:39:21 SYZFATAL: BUG: program execution failed: executor 0: exit status 67
SYZFAIL: ebtable checkpoint: getsockopt(EBT_SO_GET_INIT_INFO) failed
table=broute (errno 22: Invalid argument)
loop exited with status 67

SYZFAIL: ebtable checkpoint: getsockopt(EBT_SO_GET_INIT_INFO) failed
table=broute (errno 22: Invalid argument)
loop exited with status 67
[   46.245969][ T3557] netdevsim netdevsim0 netdevsim3 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0


syzkaller build log:
go env (err=<nil>)
GO111MODULE="auto"
GOARCH="amd64"
GOBIN=""
GOCACHE="/syzkaller/.cache/go-build"
GOENV="/syzkaller/.config/go/env"
GOEXE=""
GOEXPERIMENT=""
GOFLAGS=""
GOHOSTARCH="amd64"
GOHOSTOS="linux"
GOINSECURE=""
GOMODCACHE="/syzkaller/jobs/linux/gopath/pkg/mod"
GONOPROXY=""
GONOSUMDB=""
GOOS="linux"
GOPATH="/syzkaller/jobs/linux/gopath"
GOPRIVATE=""
GOPROXY="https://proxy.golang.org,direct"
GOROOT="/usr/local/go"
GOSUMDB="sum.golang.org"
GOTMPDIR=""
GOTOOLDIR="/usr/local/go/pkg/tool/linux_amd64"
GOVCS=""
GOVERSION="go1.17"
GCCGO="gccgo"
AR="ar"
CC="gcc"
CXX="g++"
CGO_ENABLED="1"
GOMOD="/syzkaller/jobs/linux/gopath/src/github.com/google/syzkaller/go.mod"
CGO_CFLAGS="-g -O2"
CGO_CPPFLAGS=""
CGO_CXXFLAGS="-g -O2"
CGO_FFLAGS="-g -O2"
CGO_LDFLAGS="-g -O2"
PKG_CONFIG="pkg-config"
GOGCCFLAGS="-fPIC -m64 -pthread -fmessage-length=0 -fdebug-prefix-map=/tmp/go-build2682014572=/tmp/go-build -gno-record-gcc-switches"

git status (err=<nil>)
HEAD detached at 851bc19a3
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:32: run command via tools/syz-env for best compatibility, see:
Makefile:33: https://github.com/google/syzkaller/blob/master/docs/contributing.md#using-syz-env
go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./sys/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
bin/syz-sysgen
touch .descriptions
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=851bc19a3c4615f6653414b6deec9b9e84c8ca58 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20230216-173454'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer github.com/google/syzkaller/syz-fuzzer
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=851bc19a3c4615f6653414b6deec9b9e84c8ca58 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20230216-173454'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=851bc19a3c4615f6653414b6deec9b9e84c8ca58 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20230216-173454'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wframe-larger-than=16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-format-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -static-pie -fpermissive -w -DGOOS_linux=1 -DGOARCH_amd64=1 \
	-DHOSTGOOS_linux=1 -DGIT_REVISION=\"851bc19a3c4615f6653414b6deec9b9e84c8ca58\"



Tested on:

commit:         3ac88fa4 Merge tag 'net-6.2-final' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe56f7d193926860
dashboard link: https://syzkaller.appspot.com/bug?extid=f61594de72d6705aea03
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17c96c30c80000

