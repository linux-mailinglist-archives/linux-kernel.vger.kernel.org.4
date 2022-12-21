Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567D8652A4A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 01:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234223AbiLUAIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 19:08:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233989AbiLUAIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 19:08:02 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125FB1147
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 16:07:57 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3dddef6adb6so159064417b3.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 16:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/l28VrpdxJR36n8BPcfJH7urx8J3Ny3X7SedvLlXhFY=;
        b=DDGY0KaioaBMg9g74BnWHj8j+YnrGxtfXuHAjkQP7liAEjy8bbtfLmDkY/QlDxa/vW
         mEM9hUnzXvi+F96Ebngz4suzLbkvrB5a1XUlGHxLhGFSzgiuLYm6feGhnRfNYmzHDEI+
         wqkDYZwLcFuur3ezaHbhFIVuYngh/ljCP33ZdDXhgIPCDqjxvEh31QO+xm6z+aD2P5y8
         ifpPHxxWi3LeQY++Yu5Rp5OlEoBOpjCVfNxbKdFDDbaPxEeBZ0BryHJHVMhtkKsmW0CA
         /m9xXzvsV6MOIBjdbIaPHSw2OBvCcbkkb1fFe/wrsYVjXcS5dhLm6US/CqqtKhbJKk3+
         U17A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/l28VrpdxJR36n8BPcfJH7urx8J3Ny3X7SedvLlXhFY=;
        b=zfBZhzrUHxDpSJl8LSgCSOhucD8KlzA38WcjQ8tYBvmWrEq1iHUWI/m+85MeWegJws
         HeYqnxt7Pyt+FLBJL0MxtP3xrcmwYc1vcMfWtDhTg3Uat/eSfDqwcB+6W47BnIUArjyX
         QsQCIkFJ/Up7bjZ2D8IzD23gcH/L5i+0Bv1ZrgBxBlW7djelG1CE8BIzE1coEtFK2hp1
         i8y3K5XOuRoHZ8m6NSk3N8lu8545+iRusgJ6m51DVgYDHc4hg/rexPYjw5fVKbhMI6KM
         at6n2Wi59zheAVsxxMVwvU5L1GrBzXL1BrbGFFjTdXtznzW0gYRNkKeWyA2cKvMypwqe
         A/aw==
X-Gm-Message-State: ANoB5pnMj8Fn6mT85doIHSRzjHQYhNP8vLlQxbzsauSCbOf+itgbrsd8
        QUta1/TU9jBgkDcuMmra4UIqYL0azo8=
X-Google-Smtp-Source: AA0mqf7c68uiCbx2anFZ7Hst+jpcbCju0fvPgy4WIST+J8vnR6Rh6Ag1KrVQ5xbMKXmy9sJQw3yoJSH1AME=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:a589:30f2:2daa:4ab7])
 (user=yuzhao job=sendgmr) by 2002:a25:25cf:0:b0:704:9d40:ecce with SMTP id
 l198-20020a2525cf000000b007049d40eccemr14674721ybl.316.1671581276348; Tue, 20
 Dec 2022 16:07:56 -0800 (PST)
Date:   Tue, 20 Dec 2022 17:07:48 -0700
In-Reply-To: <20221201223923.873696-1-yuzhao@google.com>
Message-Id: <20221221000748.1374772-1-yuzhao@google.com>
Mime-Version: 1.0
References: <20221201223923.873696-1-yuzhao@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: Java / POWER9 benchmark with MGLRU
From:   Yu Zhao <yuzhao@google.com>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Larabel <michael@michaellarabel.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[This is a resend. The original message was lost:
https://lore.kernel.org/r/20221219193613.998597-1-yuzhao@google.com/]

TLDR
====
SPECjbb2015 groups [1]    Critical jOPS (95% CI)    Max jOPS (95% CI)
---------------------------------------------------------------------
20                        NS                        NS
30                        +[4, 7]%                  NS
40                        OOM killed                OOM killed

Abbreviations
=============
CI:   confidence interval
NS:   no statistically significant difference
DUT:  device under test
ATE:  automatic test equipment

Rational
========
1. Java has been mostly the most popular programming language for the
   last two decades, according to the TIOBE Programming Community
   Index [2].
2. Power ISA is the longest-lasting alternative to x86 for the server
   segment [3].
3. SPECjbb2015 is the industry-standard benchmark for Java.

Hardware
========
DUT $ lscpu
Architecture:          ppc64le
  Byte Order:          Little Endian
CPU(s):                184
  On-line CPU(s) list: 0-183
Model name:            POWER9 (raw), altivec supported
  Model:               2.2 (pvr 004e 1202)
  Thread(s) per core:  4
  Core(s) per socket:  23
  Socket(s):           2
  CPU max MHz:         3000.0000
  CPU min MHz:         2300.0000
Caches (sum of all):
  L1d:                 1.4 MiB (46 instances)
  L1i:                 1.4 MiB (46 instances)
  L2:                  12 MiB (24 instances)
  L3:                  240 MiB (24 instances)
NUMA:
  NUMA node(s):        2
  NUMA node0 CPU(s):   0-91
  NUMA node1 CPU(s):   92-183
Vulnerabilities:
  Itlb multihit:       Not affected
  L1tf:                Mitigation; RFI Flush, L1D private per thread
  Mds:                 Not affected
  Meltdown:            Mitigation; RFI Flush, L1D private per thread
  Mmio stale data:     Not affected
  Retbleed:            Not affected
  Spec store bypass:   Mitigation; Kernel entry/exit barrier (eieio)
  Spectre v1:          Mitigation; __user pointer sanitization, ori31 speculation barrier enabled
  Spectre v2:          Mitigation; Indirect branch serialisation (kernel only), Indirect branch cache disabled, Software link stack flush
  Srbds:               Not affected
  Tsx async abort:     Not affected

DUT $ numactl -H
available: 2 nodes (0-1)
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45
46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91
node 0 size: 261659 MB
node 0 free: 259051 MB
node 1 cpus: 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125
126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160
161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183
node 1 size: 261713 MB
node 1 free: 257499 MB
node distances:
node   0   1
  0:  10  40
  1:  40  10

DUT $ cat /sys/class/nvme/nvme0/model
INTEL SSDPF21Q800GB

DUT $ cat /sys/class/nvme/nvme0/numa_node
0

DUT $ cat /sys/class/nvme/nvme1/model
INTEL SSDPF21Q800GB

DUT $ cat /sys/class/nvme/nvme1/numa_node
1

Software
========
DUT $ cat /etc/lsb-release
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=22.04
DISTRIB_CODENAME=jammy
DISTRIB_DESCRIPTION="Ubuntu 22.04 LTS"

DUT $ uname -a
Linux ppc 6.1.0-rc8-mglru #1 SMP Tue Dec  6 06:18:48 UTC 2022 ppc64le ppc64le ppc64le GNU/Linux

DUT $ cat /proc/swaps
Filename        Type         Size         Used  Priority
/dev/nvme0n1    partition    268435392    0     -2
/dev/nvme1n1    partition    268435392    0     -3

DUT $ java --version
openjdk 11.0.16 2022-07-19
OpenJDK Runtime Environment (build 11.0.16+8-post-Ubuntu-0ubuntu122.04)
OpenJDK 64-Bit Server VM (build 11.0.16+8-post-Ubuntu-0ubuntu122.04, mixed mode)

DUT $ cat specjbb2015/version.txt
SPECjbb2015 1.03 (11/14/2019)

Procedure
=========
DUT $ cat run_specjbb2015.sh
echo 0 >/proc/sys/kernel/numa_balancing

nodes=2
memcgs=$1

run() {
    memcg=$1
    path=/sys/fs/cgroup/memcg$memcg

    mkdir $path
    echo $BASHPID >$path/cgroup.procs

    for ((node = 0; node < $nodes; node++)); do
        group=$((nodes * memcg + node))

        numactl -N $node -m $node java -jar specjbb2015.jar \
            -m backend -G GRP$group -J JVM0 &
        numactl -N $node -m $node java -jar specjbb2015.jar \
            -m txinjector -G GRP$group -J JVM1 &
    done

    wait
}

numactl -N 0 -m 0 java -Dspecjbb.group.count=$((nodes * memcgs)) \
        -Dspecjbb.controller.rtcurve.warmup.step=0.8 \
        -jar specjbb2015.jar -m multicontroller &

for ((memcg = 0; memcg < $memcgs; memcg++)); do
    run $memcg &
done

wait

Results
=======
Critical jOPS (30 groups)
-------------------------
$ R
> a <- c(33786, 34903, 34254, 34608, 33149, 34530, 33867, 33691, 33284, 34490)
> b <- c(35192, 36691, 35771, 36399, 36321, 35177, 35792, 36145, 36594, 36207)
> t.test(a, b)

        Welch Two Sample t-test

data:  a and b
t = -7.8327, df = 17.828, p-value = 3.529e-07
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -2502.195 -1443.205
sample estimates:
mean of x mean of y
  34056.2   36028.9

Max jOPS (30 groups)
--------------------
$ R
> a <- c(61310, 60640, 60515, 59820, 60239, 60140, 60074, 60761, 59099, 59843)
> b <- c(60338, 60515, 60338, 58305, 59660, 62372, 59820, 61499, 60338, 60338)
> t.test(a, b)

        Welch Two Sample t-test

data:  a and b
t = -0.27732, df = 14.231, p-value = 0.7855
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -943.7491  727.3491
sample estimates:
mean of x mean of y
  60244.1   60352.3

References
==========
[1] https://www.spec.org/jbb2015/docs/userguide.pdf
[2] https://www.tiobe.com/tiobe-index/
[3] https://cloud.google.com/blog/products/gcp/introducing-zaius-google-and-rackspaces-open-server-running-ibm-power9
