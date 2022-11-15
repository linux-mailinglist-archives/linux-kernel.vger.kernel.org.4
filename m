Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF57A62A1E1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 20:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbiKOTa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 14:30:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiKOTaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 14:30:23 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3F822503
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 11:30:20 -0800 (PST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20221115193017euoutp0252a8c62c75ff28417db04c1c0b380877~n2NnUGzJr2913829138euoutp02j
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 19:30:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20221115193017euoutp0252a8c62c75ff28417db04c1c0b380877~n2NnUGzJr2913829138euoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1668540617;
        bh=KQTNPNGbCBavRRq1ywBTEI4FaZwHXlGcre1fygTkkz4=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=Hds35oBC1+f1/cQjYcHjjah3xQSJ43e4Gba4o5litEJfGM22gVKVs8QbdJZKx+6XK
         yS3i4Lfr029CKTe/nw0+1SFCHMQSB0tJPJCPIIGk48KJJGnvk1UUZle4hSnimWWBpv
         y4dI127J71Xx4fsfmLvvjxrghoIzXgdKbbAWDmbQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20221115193016eucas1p15dfc2b786d0fc82019b7876dfde78bc9~n2NmkDA7H1002110021eucas1p1h;
        Tue, 15 Nov 2022 19:30:16 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id BC.C9.10112.8C8E3736; Tue, 15
        Nov 2022 19:30:16 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20221115193015eucas1p18c4b8ba131b72bc9017a14568a6a54bc~n2NmL8Psd2031820318eucas1p1I;
        Tue, 15 Nov 2022 19:30:15 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221115193015eusmtrp206034920a56ed107e558406249739c64~n2NmLXsGa0754007540eusmtrp2M;
        Tue, 15 Nov 2022 19:30:15 +0000 (GMT)
X-AuditID: cbfec7f4-d09ff70000002780-9d-6373e8c89982
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 0C.6E.09026.7C8E3736; Tue, 15
        Nov 2022 19:30:15 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221115193015eusmtip1dfec2116d1594dfbf5379a8b10c5be44~n2Nlrjt2v1553915539eusmtip1m;
        Tue, 15 Nov 2022 19:30:15 +0000 (GMT)
Message-ID: <254cba04-0151-f7f1-1986-a8b763e940d1@samsung.com>
Date:   Tue, 15 Nov 2022 20:30:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH] cacheinfo: Decrement refcount in cache_setup_of_node()
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux-kernel@vger.kernel.org, Rob.Herring@arm.com,
        sudeep.holla@arm.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <CAMuHMdV_rQcKVn73ywh_KcJS2uZ0xTdzGAYcTiQov4UzRouRvQ@mail.gmail.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRjtd+8e19XkujS/Zs9VVpaWoXRDsZflSAojyopeY17U2qx21R5E
        aE9bsJa5XEubYmQs7aZNsYfGFmVLMsv10lEplilsZlnQu7Zr5X/nnO8czvf9+BG4pIwvJdIz
        MmlNhkIlE4h4tXe/NIffe8coZ9vO8qm3bfUYdbCMFVCt14sEVE2PB6NeW9Kp4gEDTr3oaUBU
        +f063gJCXnGuAsmrLccEcvvtPCS/VVwhlH+sHpfEXy+KTaFV6dm0ZlbcFlFa4a9rwh2FU3Yf
        vvEQz0HsBC3yI4CMgpzPp/haJCIk5EUEjzwFg2QAgdVmEHLkI4IOeyn2N9JuPI5zg3IElW4n
        xpF+BLm6i0KvS0zGQdmDC8iLeeQUcH3uxzg9ABxnunheHESmQKn1uU8fSSbCkXaPz4+TwdDW
        ZfbpgeRaeK//IfAW4KQLgb6oxWcSkJGgdWv/DAjCj1wJzr55XHY8HKw569sOyC4C6k9UCri1
        46G91IE4PBJ6G61CDo+BX9fMGBc4iqDk26tBokeQ0902mIgBV/NXXxtOTgf2+ixOXghVeU/4
        XhlIf3juDuCW8If82kKck8WQd0TCuUPB1Hj5X62t5TGuRzLTkGcxDTnfNOQc0//eEsSzoGA6
        i1Gn0sycDHpXBKNQM1kZqRHK7epq9OcfNf1sHKhD5b39EXaEEciOgMBlgeK1pxmlRJyi2LOX
        1mzfrMlS0YwdhRA8WbBYYAxTSshURSa9jaZ30Jq/U4zwk+ZgsXPPE8qn7z8FbuxOHrEsPOQL
        uzl3aRROqA19HYt1hxJU++NHT7uUHSvRr4iirMfDqjpCzeWRPSs0nUETJ3XW3bwUKmoGS+Wa
        xVdb1iXLhxul4jIne5IdNnXirZDVSZZJ+ezS7uYknaPBXGPb3+ReLd2w5psuN/rDHXZfm3rJ
        /F6t+3Y/EZvgyJ78obV2U4du0VGjy/+ZtKtqFC8gur7b1EMXp52aP9lzODpemr+nJPDNlWWF
        Y9nMvsiiGydWxTRm7X3ZXtDwPXl5cCKK41vD9uH+Br8m4wjTqPW2mA2y8HChoxbbmLhTRSYM
        O5B22uMqiDHM2BrnnDnG3Bo03tn5Q8Zj0hSRYbiGUfwGjnp7gLYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsVy+t/xu7rHXxQnG7xbpm3x7NZeJovmxevZ
        LC7vmsNmsfXlOyaLB6syLeZ+mcpscfPlPkaL5ad2sDhweKyZt4bRY9OqTjaPQ4c7GD32z13D
        7vF5k1wAa5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+
        XYJexvT/O9kLpqtWtO4+z9zAuF6hi5GTQ0LAROL2jG5mEFtIYCmjxP2D0RBxGYmT0xpYIWxh
        iT/Xuti6GLmAat4zSjRPWA2W4BWwk1h8dhkjiM0ioCpx59tHJoi4oMTJmU9Yuhg5OEQFUiTW
        HYkCCQsLeEu03X4HVs4sIC5x68l8sHIRgQiJZwcg5jML3GOUeDr7FyPEsmZGiUOH94ItYxMw
        lOh6C1LFwcEpEChx5b0lxCAzia6tXVBD5SWat85mnsAoNAvJGbOQ7JuFpGUWkpYFjCyrGEVS
        S4tz03OLjfSKE3OLS/PS9ZLzczcxAmNv27GfW3Ywrnz1Ue8QIxMH4yFGCQ5mJRHeiGnFyUK8
        KYmVValF+fFFpTmpxYcYTYFhMZFZSjQ5Hxj9eSXxhmYGpoYmZpYGppZmxkrivJ4FHYlCAumJ
        JanZqakFqUUwfUwcnFINTGIzNFIcmP7X+N0yk/BoWjnj6d4zW9+JbGz/xffy8snNQpdYxHmq
        z+6acHAxy1LeH1NNUtM7Fr5cVjypcBXjad+3XiaLg7izw7JcTuvP+5m8aoty/052h59PuGps
        jTetfj7x7+cdZws+tBq7qb31TFPV/closONS49S2h2YTo1y/Gvc9vqBxUXqNoQtzxM2dLOFr
        Mo1OPj6e4vqVP72mbUnZNfVVdssaNaX4/21b0PQtSfno3cXzA5KdtINq12oXVlvbl1yqPsYz
        y3K5hOH0rmU6q6a/sm70XjTjze97C1Z4Z7VXdHuYGJXrz3t09ZmDKNu/OusvCpKxM07ua11T
        tlDub6qdvcFus5CpPw+EqSuxFGckGmoxFxUnAgDkInRARgMAAA==
X-CMS-MailID: 20221115193015eucas1p18c4b8ba131b72bc9017a14568a6a54bc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20221115193015eucas1p18c4b8ba131b72bc9017a14568a6a54bc
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221115193015eucas1p18c4b8ba131b72bc9017a14568a6a54bc
References: <20221026185954.991547-1-pierre.gondois@arm.com>
        <CAMuHMdV_rQcKVn73ywh_KcJS2uZ0xTdzGAYcTiQov4UzRouRvQ@mail.gmail.com>
        <CGME20221115193015eucas1p18c4b8ba131b72bc9017a14568a6a54bc@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 15.11.2022 14:06, Geert Uytterhoeven wrote:
> On Wed, Oct 26, 2022 at 9:03 PM Pierre Gondois <pierre.gondois@arm.com> wrote:
>> Refcounts to DT nodes are only incremented in the function
>> and never decremented. Decrease the refcounts when necessary.
>>
>> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> Thanks for your patch, which is now commit 3da72e18371c41a6
> ("cacheinfo: Decrement refcount in cache_setup_of_node()") in
> driver-core-next.
>
> I have bisected a refcount underflow during s2ram to this commit:

Similar issue can be reproduced with qemu/arm64 'virt' machine during boot:

cacheinfo: Unable to detect cache hierarchy for CPU 0
------------[ cut here ]------------
refcount_t: addition on 0; use-after-free.
WARNING: CPU: 0 PID: 1 at lib/refcount.c:25 
refcount_warn_saturate+0xa0/0x144
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.1.0-rc1+ #13076
Hardware name: linux,dummy-virt (DT)
pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : refcount_warn_saturate+0xa0/0x144
lr : refcount_warn_saturate+0xa0/0x144
...
Call trace:
  refcount_warn_saturate+0xa0/0x144
  kobject_get+0xbc/0xc0
  of_node_get+0x20/0x34
  of_fwnode_get+0x34/0x54
  fwnode_handle_get+0x30/0x4c
  fwnode_get_nth_parent+0xec/0x104
  fwnode_full_name_string+0x48/0xc0
  device_node_string+0x278/0x530
  pointer+0x3a0/0x4bc
  vsnprintf+0x23c/0x750
  vprintk_store+0xf8/0x4a0
  vprintk_emit+0x110/0x360
  vprintk_default+0x38/0x44
  vprintk+0xc0/0xe4
  _printk+0x5c/0x84
  of_node_release+0x140/0x150
  kobject_put+0xa4/0x120
  of_node_put+0x18/0x2c
  free_cache_attributes+0x13c/0x1e0
  detect_cache_attributes+0x4f4/0x580
  update_siblings_masks+0x28/0x300
  store_cpu_topology+0x58/0x80
  smp_prepare_cpus+0x38/0x120
  kernel_init_freeable+0x1b8/0x350
  kernel_init+0x24/0x130
  ret_from_fork+0x10/0x20
irq event stamp: 74
hardirqs last  enabled at (73): [<ffffb81addf20ac0>] 
__up_console_sem+0x6c/0x70
hardirqs last disabled at (74): [<ffffb81addf22658>] 
vprintk_store+0x298/0x4a0
softirqs last  enabled at (10): [<ffffb81adde1046c>] _stext+0x46c/0x5d8
softirqs last disabled at (3): [<ffffb81adde166d0>] ____do_softirq+0x10/0x20
---[ end trace 0000000000000000 ]---


I've also observed it during the manual CPU hot plug test (the log comes 
from OdroidC4 board):

# for i in /sys/devices/system/cpu/cpu[1-8]; do echo 0 >$i/online;

psci: CPU1 killed (polled 4 ms)
------------[ cut here ]------------
refcount_t: addition on 0; use-after-free.
WARNING: CPU: 2 PID: 23 at lib/refcount.c:25 
refcount_warn_saturate+0xa0/0x144
Modules linked in: ipv6 meson_gxl dw_hdmi_i2s_audio dwmac_generic 
rc_odroid axg_audio sclk_div clk_phase mdio_mux_meson_g12a meson_ir 
snd_soc_meson_axg_tdmout snd
son_g12a_tohdmitx snd_soc_meson_codec_glue crct10dif_ce 
snd_soc_meson_axg_fifo meson_gxbb_wdt reset_meson_audio_arb pwm_meson 
meson_dw_hdmi meson_rng rtc_meson_vr
_platform snd_soc_meson_axg_sound_card drm_display_helper rng_core 
snd_soc_meson_card_utils stmmac panfrost meson_drm drm_shmem_helper 
snd_soc_meson_axg_tdm_inter
anvas nvmem_meson_efuse snd_soc_meson_axg_tdm_formatter display_connector
CPU: 2 PID: 23 Comm: cpuhp/2 Not tainted 6.1.0-rc5-next-20221115+ #5935
Hardware name: Hardkernel ODROID-C4 (DT)
pstate: 604000c9 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : refcount_warn_saturate+0xa0/0x144
lr : refcount_warn_saturate+0xa0/0x144
...
Call trace:
  refcount_warn_saturate+0xa0/0x144
  kobject_get+0xbc/0xc0
  of_node_get+0x20/0x34
  of_fwnode_get+0x34/0x54
  fwnode_handle_get+0x30/0x4c
  fwnode_get_nth_parent+0xec/0x104
  fwnode_full_name_string+0x48/0xc0
  device_node_string+0x278/0x530
  pointer+0x3a0/0x4bc
  vsnprintf+0x23c/0x750
  vprintk_store+0xf8/0x4a0
  vprintk_emit+0x10c/0x35c
  vprintk_default+0x38/0x44
  vprintk+0xc0/0xe4
  _printk+0x5c/0x84
  of_node_release+0x140/0x150
  kobject_put+0xa4/0x120
  of_node_put+0x18/0x2c
  free_cache_attributes+0x13c/0x1e0
  cacheinfo_cpu_pre_down+0x80/0x90
  cpuhp_invoke_callback+0x16c/0x2b0
  cpuhp_thread_fun+0x18c/0x250
  smpboot_thread_fn+0x1f4/0x2a0
  kthread+0x118/0x11c
  ret_from_fork+0x10/0x20
irq event stamp: 204
hardirqs last  enabled at (203): [<ffff800008330260>] 
put_cpu_partial+0x1bc/0x1fc
hardirqs last disabled at (204): [<ffff8000081247ac>] 
vprintk_store+0x298/0x4a0
softirqs last  enabled at (16): [<ffff80000801046c>] _stext+0x46c/0x5d8
softirqs last disabled at (3): [<ffff800008016700>] ____do_softirq+0x10/0x20
---[ end trace 0000000000000000 ]---


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

