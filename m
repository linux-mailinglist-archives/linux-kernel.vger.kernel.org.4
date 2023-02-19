Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3BCD69C022
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 13:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjBSMIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 07:08:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBSMIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 07:08:04 -0500
Received: from vulcan.natalenko.name (vulcan.natalenko.name [104.207.131.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD83B45E;
        Sun, 19 Feb 2023 04:08:02 -0800 (PST)
Received: from spock.localnet (unknown [83.148.33.151])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 7DB121236EF0;
        Sun, 19 Feb 2023 13:07:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1676808479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k0uQYrDXseOdnKUU40UXg4bhZFZZLcIfSAnfKuTK3PU=;
        b=EWEPayuOGH7VvY1bL8s4lxiz04TA1iL8Lc6W06Uxpe/fBG/tQaXi4Zqegu7WolFL0/oAMJ
        Uangk5SKERlGYMnfcKpAO/8Um0/ENyRfBw6V4YgoQAD3eKKw+fnlR8lxtA80Uqw0Ott2do
        GTSXKrk8PQyf752lWr+kx803t4U39gk=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Rafael J Wysocki <rafael@kernel.org>,
        Huang Rui <ray.huang@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Mario.Limonciello@amd.com, Perry.Yuan@amd.com,
        Wyes Karny <wyes.karny@amd.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        santosh.shukla@amd.com, Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Ananth Narayan <ananth.narayan@amd.com>,
        gautham.shenoy@amd.com, Tor Vic <torvic9@mailbox.org>,
        Russell Haley <yumpusamongus@gmail.com>,
        Wyes Karny <wyes.karny@amd.com>
Subject: Re: [PATCH v7 0/6] cpufreq: amd-pstate: Add guided autonomous mode support
Date:   Sun, 19 Feb 2023 13:07:57 +0100
Message-ID: <5906931.lOV4Wx5bFT@natalenko.name>
In-Reply-To: <20230216081802.38007-1-wyes.karny@amd.com>
References: <20230216081802.38007-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On =C4=8Dtvrtek 16. =C3=BAnora 2023 9:17:56 CET Wyes Karny wrote:
> >From ACPI spec[1] below 3 modes for CPPC can be defined:
> 1. Non autonomous: OS scaling governor specifies operating frequency/
>    performance level through `Desired Performance` register and platform
> follows that.
> 2. Guided autonomous: OS scaling governor specifies min and max
>    frequencies/ performance levels through `Minimum Performance` and
> `Maximum Performance` register, and platform can autonomously select an
> operating frequency in this range.
> 3. Fully autonomous: OS only hints (via EPP) to platform for the required
>    energy performance preference for the workload and platform autonomous=
ly
> scales the frequency.
>=20
> Currently (1) is supported by amd_pstate as passive mode, and (3) is
> implemented by EPP support[2]. This change is to support (2).
>=20
> In guided autonomous mode the min_perf is based on the input from the
> scaling governor. For example, in case of schedutil this value depends
> on the current utilization. And max_perf is set to max capacity.
>=20
> To activate guided auto mode ``amd_pstate=3Dguided`` command line
> parameter has to be passed in the kernel.
>=20
> Below are the results (normalized) of benchmarks with this patch:
> System: Genoa 96C 192T
> Kernel: 6.2.0-rc2 + EPP v12 + patch
> Scaling governor: schedutil
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D dbench comparisons =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> dbench result comparison:
> Here results are throughput (MB/s)
> Clients:   acpi-cpufreq		   amd_pst+passive	   amd_pst+guided
>     1	   1.00 (0.00 pct)	   1.01 (1.00 pct)	   1.02 (2.00 pct)
>     2	   1.07 (0.00 pct)	   1.06 (-0.93 pct)	   1.07 (0.00 pct)
>     4	   1.68 (0.00 pct)	   1.70 (1.19 pct)	   1.72 (2.38 pct)
>     8	   2.61 (0.00 pct)	   2.68 (2.68 pct)	   2.76 (5.74 pct)
>    16	   4.16 (0.00 pct)	   4.24 (1.92 pct)	   4.53 (8.89 pct)
>    32	   5.98 (0.00 pct)	   6.17 (3.17 pct)	   7.30 (22.07 pct)
>    64	   8.67 (0.00 pct)	   8.99 (3.69 pct)	  10.71 (23.52 pct)
>   128	  11.98 (0.00 pct)	  12.52 (4.50 pct)	  14.67 (22.45 pct)
>   256	  15.73 (0.00 pct)	  16.13 (2.54 pct)	  17.81 (13.22 pct)
>   512	  15.77 (0.00 pct)	  16.32 (3.48 pct)	  16.39 (3.93 pct)
> dbench power comparison:
> Clients:   acpi-cpufreq		   amd_pst+passive	   amd_pst+guided
>     1	   1.00 (0.00 pct)	   1.00 (0.00 pct)	   1.04 (4.00 pct)
>     2	   0.99 (0.00 pct)	   0.97 (-2.02 pct)	   1.02 (3.03 pct)
>     4	   0.98 (0.00 pct)	   0.98 (0.00 pct)	   1.02 (4.08 pct)
>     8	   0.98 (0.00 pct)	   0.99 (1.02 pct)	   1.02 (4.08 pct)
>    16	   0.99 (0.00 pct)	   1.00 (1.01 pct)	   1.04 (5.05 pct)
>    32	   1.02 (0.00 pct)	   1.02 (0.00 pct)	   1.07 (4.90 pct)
>    64	   1.05 (0.00 pct)	   1.05 (0.00 pct)	   1.11 (5.71 pct)
>   128	   1.08 (0.00 pct)	   1.08 (0.00 pct)	   1.15 (6.48 pct)
>   256	   1.12 (0.00 pct)	   1.12 (0.00 pct)	   1.20 (7.14 pct)
>   512	   1.18 (0.00 pct)	   1.17 (-0.84 pct)	   1.26 (6.77 pct)
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D git-source comparisons =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> git-source result comparison:
> Here results are throughput (compilations per 1000 sec)
> Threads:   acpi-cpufreq		   amd_pst+passive	   amd_pst+guided
>   192	   1.00 (0.00 pct)	   0.93 (-7.00 pct)	   1.00 (0.00 pct)
> git-source power comparison:
> Threads:   acpi-cpufreq		   amd_pst+passive	   amd_pst+guided
>   192	   1.00 (0.00 pct)	   1.00 (0.00 pct)	   0.96 (-4.00 pct)
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D kernbench comparisons =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> kernbench result comparison:
> Here results are throughput (compilations per 1000 sec)
> Load:	   acpi-cpufreq		   amd_pst+passive	   amd_pst+guided
> 32	   1.00 (0.00 pct)	   1.01 (1.00 pct)	   1.02 (2.00 pct)
> 48	   1.26 (0.00 pct)	   1.28 (1.58 pct)	   1.25 (-0.79 pct)
> 64	   1.39 (0.00 pct)	   1.47 (5.75 pct)	   1.43 (2.87 pct)
> 96	   1.48 (0.00 pct)	   1.50 (1.35 pct)	   1.49 (0.67 pct)
> 128	   1.29 (0.00 pct)	   1.32 (2.32 pct)	   1.33 (3.10 pct)
> 192	   1.17 (0.00 pct)	   1.20 (2.56 pct)	   1.21 (3.41 pct)
> 256	   1.17 (0.00 pct)	   1.18 (0.85 pct)	   1.20 (2.56 pct)
> 384	   1.16 (0.00 pct)	   1.17 (0.86 pct)	   1.21 (4.31 pct)
> kernbench power comparison:
> Clients:   acpi-cpufreq		   amd_pst+passive	   amd_pst+guided
>    32	   1.00 (0.00 pct)	   0.97 (-3.00 pct)	   1.00 (0.00 pct)
>    48	   0.87 (0.00 pct)	   0.81 (-6.89 pct)	   0.88 (1.14 pct)
>    64	   0.81 (0.00 pct)	   0.73 (-9.87 pct)	   0.77 (-4.93 pct)
>    96	   0.75 (0.00 pct)	   0.74 (-1.33 pct)	   0.75 (0.00 pct)
>   128	   0.83 (0.00 pct)	   0.79 (-4.81 pct)	   0.83 (0.00 pct)
>   192	   0.92 (0.00 pct)	   0.88 (-4.34 pct)	   0.92 (0.00 pct)
>   256	   0.92 (0.00 pct)	   0.88 (-4.34 pct)	   0.92 (0.00 pct)
>   384	   0.92 (0.00 pct)	   0.88 (-4.34 pct)	   0.92 (0.00 pct)
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D tbench comparisons =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> tbench result comparison:
> Here results are throughput (MB/s)
> Clients:   acpi-cpufreq		   amd_pst+passive	   amd_pst+guided
>     1	   1.00 (0.00 pct)	   0.70 (-30.00 pct)	   1.37 (37.00 pct)
>     2	   2.64 (0.00 pct)	   1.39 (-47.34 pct)	   2.70 (2.27 pct)
>     4	   4.89 (0.00 pct)	   2.75 (-43.76 pct)	   5.28 (7.97 pct)
>     8	   9.46 (0.00 pct)	   5.42 (-42.70 pct)	  10.22 (8.03 pct)
>    16	  19.05 (0.00 pct)	  10.42 (-45.30 pct)	  19.94 (4.67 pct)
>    32	  37.50 (0.00 pct)	  20.23 (-46.05 pct)	  36.87 (-1.68 pct)
>    64	  61.24 (0.00 pct)	  43.08 (-29.65 pct)	  62.96 (2.80 pct)
>   128	  67.16 (0.00 pct)	  69.08 (2.85 pct)	  67.34 (0.26 pct)
>   256	 154.59 (0.00 pct)	 162.33 (5.00 pct)	 156.78 (1.41 pct)
>   512	 154.02 (0.00 pct)	 156.74 (1.76 pct)	 153.48 (-0.35 pct)
> tbench power comparison:
> Clients:   acpi-cpufreq		   amd_pst+passive	   amd_pst+guided
>     1	   1.00 (0.00 pct)	   0.97 (-3.00 pct)	   1.08 (8.00 pct)
>     2	   1.04 (0.00 pct)	   0.97 (-6.73 pct)	   1.11 (6.73 pct)
>     4	   1.12 (0.00 pct)	   0.99 (-11.60 pct)	   1.18 (5.35 pct)
>     8	   1.25 (0.00 pct)	   1.04 (-16.80 pct)	   1.31 (4.80 pct)
>    16	   1.53 (0.00 pct)	   1.13 (-26.14 pct)	   1.58 (3.26 pct)
>    32	   2.01 (0.00 pct)	   1.36 (-32.33 pct)	   2.03 (0.99 pct)
>    64	   2.58 (0.00 pct)	   2.14 (-17.05 pct)	   2.61 (1.16 pct)
>   128	   2.80 (0.00 pct)	   2.81 (0.35 pct)	   2.81 (0.35 pct)
>   256	   3.39 (0.00 pct)	   3.43 (1.17 pct)	   3.42 (0.88 pct)
>   512	   3.44 (0.00 pct)	   3.44 (0.00 pct)	   3.44 (0.00 pct)
>=20
> Note: this series is based on top of EPP v12 [3] series
>=20
> Change log:
>=20
> v6 -> v7:
> - Addressed comments by Ray
> - Reorder and rebase patches
> - Pick up Ack by Ray
>=20
> v5 -> v6:
> - Don't return -EBUSY when changing to same mode
>=20
> v4 -> v5:
> - Rebased on top of EPP v12 series
> - Addressed comments form Mario regarding documentation
> - Picked up RB flags from Mario and Bagas Sanjaya
>=20
> v3 -> v4:
> - Fixed active mode low frequency issue reported by Peter Jung and Tor Vic
> - Documentation modification suggested by Bagas Sanjaya
>=20
> v2 -> v3:
> - Addressed review comments form Mario.
> - Picked up RB tag from Mario.
> - Rebase on top of EPP v11 [3].
>=20
> v1 -> v2:
> - Fix issue with shared mem systems.
> - Rebase on top of EPP series.
>=20
> [1]: https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.=
pdf
> [2]: https://lore.kernel.org/lkml/20221110175847.3098728-1-Perry.Yuan@amd=
=2Ecom/
> [3]: https://lore.kernel.org/linux-pm/20230131090016.3970625-1-perry.yuan=
@amd.com/
>=20
> Wyes Karny (6):
>   acpi: cppc: Add min and max perf reg writing support
>   acpi: cppc: Add auto select register read/write support
>   Documentation: cpufreq: amd-pstate: Move amd_pstate param to
>     alphabetical order
>   cpufreq: amd-pstate: Add guided autonomous mode
>   cpufreq: amd-pstate: Add guided mode control support via sysfs
>   Documentation: cpufreq: amd-pstate: Update amd_pstate status sysfs for
>     guided
>=20
>  .../admin-guide/kernel-parameters.txt         |  40 ++--
>  Documentation/admin-guide/pm/amd-pstate.rst   |  31 ++-
>  drivers/acpi/cppc_acpi.c                      | 121 +++++++++++-
>  drivers/cpufreq/amd-pstate.c                  | 177 +++++++++++++-----
>  include/acpi/cppc_acpi.h                      |  11 ++
>  include/linux/amd-pstate.h                    |   2 +
>  6 files changed, 302 insertions(+), 80 deletions(-)

```
$ lscpu | grep 'Model name'
Model name:                      AMD Ryzen 9 5950X 16-Core Processor

$ cat /proc/cmdline
root=3D/dev/mapper/system threadirqs io_delay=3Dnone zswap.enabled=3D0 amd_=
pstate=3Dguided quiet

$ sudo cpupower frequency-info
analyzing CPU 0:
driver: amd-pstate
CPUs which run at the same hardware frequency: 0
CPUs which need to have their frequency coordinated by software: 0
maximum transition latency: 20.0 us
hardware limits: 550 MHz - 5.08 GHz
available cpufreq governors: conservative ondemand userspace powersave perf=
ormance schedutil
current policy: frequency should be within 550 MHz and 5.08 GHz.
The governor "schedutil" may decide which speed to use
within this range.
current CPU frequency: Unable to call hardware
current CPU frequency: 3.95 GHz (asserted by call to kernel)
boost state support:
Supported: yes
Active: yes
AMD PSTATE Highest Performance: 166. Maximum Frequency: 5.08 GHz.
AMD PSTATE Nominal Performance: 111. Nominal Frequency: 3.40 GHz.
AMD PSTATE Lowest Non-linear Performance: 57. Lowest Non-linear Frequency: =
1.74 GHz.
AMD PSTATE Lowest Performance: 19. Lowest Frequency: 550 MHz.
```

Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>

Thank you.

=2D-=20
Oleksandr Natalenko (post-factum)


