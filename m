Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7996004D5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 03:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiJQB0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 21:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiJQB0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 21:26:42 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C041D0D5
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 18:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665970000; x=1697506000;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JdlIe04D8xtdnHZv6niVJhaqat4KKqvNTduy2VqT1b0=;
  b=PHMkbWUxEsNmZXBSS7DERRrO/MoADpuKA01lpppDD9a4GKaOibS4GVkm
   bv9VOVCiU15+EUgRDWF3ctfWPz0I/5Iq9OYwHtig/J3+B1uOQq0gVZfMB
   JyVWkRgiy2UmHIUC6Rs/8VFWTPoCVECugKxelcgywX18RJHKbb5fyppnE
   GWAQHwoxmQb5O5J+skOIHacNM35XVPn5ylFCDEak2qjlQkUQ5aZzHFMzC
   1gPF/JlswhRLRCC8Hy23TGhVVJwgpJJKuuf9p6S7klCbbwq+DVnqw/R+g
   Pyk6VRyroZ1l/bDFsVMPVVUe14bhV9JIePF/M2kPAAtk2zT67eL+b3PUE
   g==;
X-IronPort-AV: E=Sophos;i="5.95,190,1661788800"; 
   d="scan'208";a="213965995"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Oct 2022 09:26:37 +0800
IronPort-SDR: uqCQIadHtDQngmcTX7cZqluDvshT/W5LfdqNNztdWEzMLE+irty0Pj6+3GNDHyIQQdLi33KhGY
 IIOodf6TB5gzOmMMQ/UvPr5QvNMWhx3U/s+sjHPtRJWavpxGicc20341GLYBiO3XDMXg6D/8Ln
 45MHjKjZEm7IP2LW+f4iHcb3CykBSNS8VMwJrASGYUtu84JlLNM1QB5p/WvNr8JT3yw0JArOws
 51z+8W14NEshO5jRq3c/7BkrwvSRXHTy5rPNRQX3rI8DFr2dx9Pumq4ILNbEEQGsa0ZnWaanJA
 csmoF8vn2/3deXN773fHrVpL
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2022 17:40:32 -0700
IronPort-SDR: ysprJoL5724mcBU1bZjgTYWnTmvYTk8w8ojHInVTdJL5tTS/M+/kVkVGN+IHIp9VjjXdZP5cxx
 gJGwvKF0E9Na1f0uqFxX/G7YNywt8mS7M4gW7NntmQ3fQKxToXgby3WKesETZwZOKV9JrAI1Hl
 5RElH5yCPOWR9B+k81XfbFDBsF0ghI5XBHHI2f25ZGyj+ayxjLmo1zjF1n98JEIs9RvzbrjhV6
 inf55IuFzE4zCrTeRpIPuO4xfdsOIEc2j0rLdEGiv2y7Tl04B8obgZn1LS2qV7S4Z5x7VcGlNp
 omU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2022 18:26:37 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MrK8Y0YvFz1Rwtl
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 18:26:37 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1665969993; x=1668561994; bh=JdlIe04D8xtdnHZv6niVJhaqat4KKqvNTdu
        y2VqT1b0=; b=joLLoWjS9UNbRdmgJPJIVotOXCio3oeZEex9p6kcF4ADV5lea+/
        E+RyzfeZCSgDT9NdsEF34xSjmHhd7rzvZH9qag4oCy5mgHt7pcfNia69vaEFuiJH
        0H6jzYu89DkqH89QTtBHwCPfUHaVxyfZAfTpHpSJWUitRS8ltomJPA4Ct851qqgj
        MQGN+DSQcbAcvCg6h1zYNx/LSQ0CvApdHnR4oo9EeupsaDPmvjvV6dvsoU0Pkin9
        daJWzft3J5ZMjxbCUNGfoyYXbQ15xEA0cjK9QSeiZ3TM1pDHCnG2t2xTKISIHb7D
        2DoWd7xq9zf7G64t9AgUTamgf33lrqXJvWQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id BWmwWZn8-iGO for <linux-kernel@vger.kernel.org>;
        Sun, 16 Oct 2022 18:26:33 -0700 (PDT)
Received: from [10.225.163.121] (unknown [10.225.163.121])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MrK8R1cy9z1RvLy;
        Sun, 16 Oct 2022 18:26:31 -0700 (PDT)
Message-ID: <1636ebe1-68eb-b754-fc1f-00d8be7b728b@opensource.wdc.com>
Date:   Mon, 17 Oct 2022 10:26:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] null_blk: allow teardown on request timeout
To:     Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, johannes.thumshirn@wdc.com, bvanassche@acm.org,
        ming.lei@redhat.com, shinichiro.kawasaki@wdc.com,
        vincent.fu@samsung.com, yukuai3@huawei.com
References: <20221016052006.11126-1-kch@nvidia.com>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221016052006.11126-1-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/22 14:20, Chaitanya Kulkarni wrote:
> In current timeout implementation null_blk just completes the request
> with error=3DBLK_STS_TIMEOUT without doing any cleanup, hence device
> cleanup code including handling inflight requests on timeout and
> teardown is never exercised.
>=20
> Add a module parameter rq_abort_limit to allow null_blk perform device
> cleanup when time out occurs. The non zero value of this parameter
> allows user to set the number of timeouts to occur before triggering
> cleanup/teardown work.
>=20
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
> * Test result enabling the rq_abort_limit from module parameter and
>   issueing dd until null_blk device disappears from the pathname
>   with connetion timeout error.
> =20
> linux-block (for-next) # !./test_
> ./test_null_blk_abort_on_timeout.sh=20
> commit 4fbcf978ae8f385aa1830ce40f210c7eec8d58fa (HEAD -> for-next)
> Author: Chaitanya Kulkarni <kch@nvidia.com>
> Date:   Tue Oct 11 23:22:43 2022 -0700
>=20
>     null_blk: allow teardown on request timeout
>    =20
>     In current timeout implementation null_blk just completes the reque=
st
>     with error=3DBLK_STS_TIMEOUT without doing any cleanup, hence devic=
e
>     cleanup code including handling inflight requests on timeout and
>     teardown is never exercised.
>    =20
>     Add a module parameter rq_abort_limit to allow null_blk perform dev=
ice
>     cleanup when time out occurs. The non zero value of this parameter
>     allows user to set the number of timeouts to occur before triggerin=
g
>     cleanup/teardown work.
>    =20
>     Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> + umount /mnt/nullb0
> umount: /mnt/nullb0: not mounted.
> + rmdir 'config/nullb/nullb*'
> rmdir: failed to remove 'config/nullb/nullb*': No such file or director=
y
> + dmesg -c
> + modprobe -r null_blk
> + lsmod
> + grep null_blk
> ++ nproc
> + make -j 48 M=3Ddrivers/block modules
>   CC [M]  drivers/block/null_blk/main.o
>   CC [M]  drivers/block/null_blk/trace.o
>   CC [M]  drivers/block/null_blk/zoned.o
>   LD [M]  drivers/block/null_blk/null_blk.o
>   MODPOST drivers/block/Module.symvers
>   LD [M]  drivers/block/null_blk/null_blk.ko
> + HOST=3Ddrivers/block/null_blk/
> ++ uname -r
> + HOST_DEST=3D/lib/modules/6.0.0blk+/kernel/drivers/block/null_blk/
> + cp drivers/block/null_blk//null_blk.ko /lib/modules/6.0.0blk+/kernel/=
drivers/block/null_blk//
> + ls -lrth /lib/modules/6.0.0blk+/kernel/drivers/block/null_blk//null_b=
lk.ko
> -rw-r--r--. 1 root root 1.2M Oct 15 21:51 /lib/modules/6.0.0blk+/kernel=
/drivers/block/null_blk//null_blk.ko
> + sleep 1
> + dmesg -c
> ##################
> ##################
> nullb0  250:0    0  250G  0 disk=20
> dd: error writing '/dev/nullb0': Connection timed out
> 3+0 records in
> 2+0 records out
> 8192 bytes (8.2 kB, 8.0 KiB) copied, 6.13436 s, 1.3 kB/s
> ##################
> ##################
> nullb0  250:0    0  250G  0 disk=20
> [ 1598.393544] null_blk: rq 0000000015ff5165 timed out
> [ 1598.393555] blk_print_req_error: 74 callbacks suppressed
> [ 1598.393558] timeout error, dev nullb0, sector 8 op 0x0:(READ) flags =
0x0 phys_seg 1 prio class 2
> [ 1598.395885] Buffer I/O error on dev nullb0, logical block 1, async p=
age read
> [ 1598.397731] Dev nullb0: unable to read RDB block 8
> [ 1598.398990]  nullb0: unable to read partition table
> [ 1598.399069] null_blk: disk nullb0 created
> [ 1598.399071] null_blk: module loaded
> [ 1604.537424] null_blk: rq 00000000b2a753f0 timed out
> [ 1604.537437] timeout error, dev nullb0, sector 16 op 0x1:(WRITE) flag=
s 0x8800 phys_seg 1 prio class 2
> dd: error writing '/dev/nullb0': Connection timed out
> 1+0 records in
> 0+0 records out
> 0 bytes copied, 6.13561 s, 0.0 kB/s
> ##################
> ##################
> nullb0  250:0    0  250G  0 disk=20
> [ 1610.681242] null_blk: rq 00000000a392790b timed out
> [ 1610.681253] timeout error, dev nullb0, sector 0 op 0x1:(WRITE) flags=
 0x8800 phys_seg 1 prio class 2
> dd: error writing '/dev/nullb0': Connection timed out
> 1+0 records in
> 0+0 records out
> 0 bytes copied, 6.13985 s, 0.0 kB/s
> ##################
> ##################
> nullb0  250:0    0  250G  0 disk=20
> [ 1616.825155] null_blk: rq 0000000091a70f01 timed out
> [ 1616.825168] timeout error, dev nullb0, sector 0 op 0x1:(WRITE) flags=
 0x8800 phys_seg 1 prio class 2
> dd: error writing '/dev/nullb0': Connection timed out
> 1+0 records in
> 0+0 records out
> 0 bytes copied, 6.1325 s, 0.0 kB/s
> ##################
> ##################
> nullb0  250:0    0  250G  0 disk=20
> [ 1622.969017] null_blk: rq 00000000cdb610e7 timed out
> [ 1622.969029] timeout error, dev nullb0, sector 0 op 0x1:(WRITE) flags=
 0x8800 phys_seg 1 prio class 2
> dd: error writing '/dev/nullb0': Connection timed out
> 2+0 records in
> 1+0 records out
> 4096 bytes (4.1 kB, 4.0 KiB) copied, 6.14283 s, 0.7 kB/s
> ##################
> ##################
> [ 1629.112893] null_blk: rq 00000000555ecc5e timed out
> [ 1629.118817] blk_sync_queue 230
> [ 1629.118821] blk_sync_queue 232
> [ 1629.118823] blk_sync_queue 234
> [ 1629.118828] timeout error, dev nullb0, sector 8 op 0x1:(WRITE) flags=
 0x8800 phys_seg 1 prio class 2
> [ 1629.125044] blk_sync_queue 230
> [ 1629.125048] blk_sync_queue 232
> [ 1629.125049] blk_sync_queue 234
> ##################
> ##################
>=20
> * Test result enabling the rq_abort_limit from module parameter and
>   issueing fio until null_blk device disappears from the pathname
>   with connetion timeout error.
> nullb0  250:0    0  250G  0 disk=20
> RANDREAD: (g=3D0): rw=3Drandread, bs=3D(R) 4096B-4096B, (W) 4096B-4096B=
, (T) 4096B-4096B, ioengine=3Dlibaio, iodepth=3D128
> fio-3.27
> Starting 1 process
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
214274048, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
32268288, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
107802624, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
193708032, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
202928128, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
281436160, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
33292288, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
250576896, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
41902080, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
225521664, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
303058944, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
405196800, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
309719040, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
111214592, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
254062592, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
128663552, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
76795904, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
355647488, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
5873664, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
69328896, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
216276992, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
16027648, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
328343552, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
385630208, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
137695232, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
146546688, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
157765632, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
290615296, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
230440960, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
130961408, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
88547328, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
157401088, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
296202240, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
35819520, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
212545536, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
261697536, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
66195456, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
254603264, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
169242624, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
258154496, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
69320704, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
335650816, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
192950272, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
32813056, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
5804032, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
217219072, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
153227264, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
91131904, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
241209344, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
246509568, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
332935168, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
108859392, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
86061056, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
278966272, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
219004928, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
290512896, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
143306752, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
176312320, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
346566656, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
183422976, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
383885312, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
199393280, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
160944128, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
142491648, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
217841664, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
178466816, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
331423744, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
88883200, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
311562240, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
228642816, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
362893312, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Connection timed out: read offset=3D=
323035136, buflen=3D4096
> fio: io_u error on file /dev/nullb0: Input/output error: read offset=3D=
385089536, buflen=3D4096
> fio: pid=3D7811, err=3D110/file:io_u.c:1841, func=3Dio_u error, error=3D=
Connection timed out
>=20
> RANDREAD: (groupid=3D0, jobs=3D1): err=3D110 (file:io_u.c:1841, func=3D=
io_u error, error=3DConnection timed out): pid=3D7811: Sat Oct 15 21:52:0=
9 2022
>   read: IOPS=3D33, BW=3D64.6KiB/s (66.1kB/s)(420KiB/6503msec)
>     slat (nsec): min=3D942, max=3D6485.4M, avg=3D29824299.02, stdev=3D4=
39245367.62
>     clat (usec): min=3D525, max=3D6501.3k, avg=3D3899782.52, stdev=3D31=
94606.52
>      lat (usec): min=3D530, max=3D6501.3k, avg=3D3961597.01, stdev=3D31=
81404.42
>     clat percentiles (usec):
>      |  1.00th=3D[    545],  5.00th=3D[    553], 10.00th=3D[    562],
>      | 20.00th=3D[    611], 30.00th=3D[  15795], 40.00th=3D[  15795],
>      | 50.00th=3D[6476006], 60.00th=3D[6476006], 70.00th=3D[6476006],
>      | 80.00th=3D[6476006], 90.00th=3D[6476006], 95.00th=3D[6476006],
>      | 99.00th=3D[6476006], 99.50th=3D[6476006], 99.90th=3D[6476006],
>      | 99.95th=3D[6476006], 99.99th=3D[6476006]
>    bw (  KiB/s): min=3D  216, max=3D  216, per=3D100.00%, avg=3D216.00,=
 stdev=3D 0.00, samples=3D1
>    iops        : min=3D   54, max=3D   54, avg=3D54.00, stdev=3D 0.00, =
samples=3D1
>   lat (usec)   : 750=3D12.39%
>   lat (msec)   : 20=3D6.88%, >=3D2000=3D28.90%
>   cpu          : usr=3D0.00%, sys=3D0.00%, ctx=3D4, majf=3D0, minf=3D15=
0
>   IO depths    : 1=3D0.5%, 2=3D0.9%, 4=3D1.8%, 8=3D3.7%, 16=3D7.3%, 32=3D=
14.7%, >=3D64=3D71.1%
>      submit    : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, =
64=3D0.0%, >=3D64=3D0.0%
>      complete  : 0=3D0.0%, 4=3D98.9%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 6=
4=3D0.0%, >=3D64=3D1.1%
>      issued rwts: total=3D218,0,0,0 short=3D40,0,0,0 dropped=3D0,0,0,0
>      latency   : target=3D0, window=3D0, percentile=3D100.00%, depth=3D=
128
>=20
> Run status group 0 (all jobs):
>    READ: bw=3D64.6KiB/s (66.1kB/s), 64.6KiB/s-64.6KiB/s (66.1kB/s-66.1k=
B/s), io=3D420KiB (430kB), run=3D6503-6503msec
>=20
> Disk stats (read/write):
>   nullb0: ios=3D90/0, merge=3D0/0, ticks=3D0/0, in_queue=3D0, util=3D98=
.55%
> ##################
> ##################
> [ 1635.256737] null_blk: rq 00000000834b8ba3 timed out
> [ 1635.256748] timeout error, dev nullb0, sector 0 op 0x0:(READ) flags =
0x0 phys_seg 1 prio class 2
> [ 1635.258876] Buffer I/O error on dev nullb0, logical block 0, async p=
age read
> [ 1641.400625] null_blk: rq 00000000ee97fbff timed out
> [ 1641.400636] timeout error, dev nullb0, sector 8 op 0x0:(READ) flags =
0x0 phys_seg 1 prio class 2
> [ 1641.402919] Buffer I/O error on dev nullb0, logical block 1, async p=
age read
> [ 1641.404755] Dev nullb0: unable to read RDB block 8
> [ 1641.406666]  nullb0: unable to read partition table
> [ 1641.407559] null_blk: disk nullb0 created
> [ 1641.407562] null_blk: module loaded
> [ 1648.056420] null_blk: rq 00000000834b8ba3 timed out
> [ 1648.056432] timeout error, dev nullb0, sector 418504 op 0x0:(READ) f=
lags 0x0 phys_seg 1 prio class 2
> [ 1648.058914] null_blk: rq 0000000064c974a9 timed out
> [ 1648.058918] timeout error, dev nullb0, sector 63024 op 0x0:(READ) fl=
ags 0x0 phys_seg 1 prio class 2
> [ 1648.061288] null_blk: rq 00000000ee97fbff timed out
> [ 1648.061291] timeout error, dev nullb0, sector 210552 op 0x0:(READ) f=
lags 0x0 phys_seg 1 prio class 2
> [ 1648.063663] null_blk: rq 000000006c6fa717 timed out
> [ 1648.063667] timeout error, dev nullb0, sector 378336 op 0x0:(READ) f=
lags 0x0 phys_seg 1 prio class 2
> [ 1648.066011] null_blk: rq 00000000fa856166 timed out
> [ 1648.066015] null_blk: rq 00000000de9bec9a timed out
> [ 1648.066016] timeout error, dev nullb0, sector 396344 op 0x0:(READ) f=
lags 0x0 phys_seg 1 prio class 2
> [ 1648.068390] null_blk: rq 00000000f12b4b17 timed out
> [ 1648.068393] timeout error, dev nullb0, sector 549680 op 0x0:(READ) f=
lags 0x0 phys_seg 1 prio class 2
> [ 1648.071389] null_blk: rq 00000000667726b2 timed out
> [ 1648.071393] timeout error, dev nullb0, sector 65024 op 0x0:(READ) fl=
ags 0x0 phys_seg 1 prio class 2
> [ 1648.073740] null_blk: rq 0000000088f0f903 timed out
> [ 1648.073744] timeout error, dev nullb0, sector 489408 op 0x0:(READ) f=
lags 0x0 phys_seg 1 prio class 2
> [ 1648.078759] null_blk: rq 00000000fd349776 timed out
> [ 1648.078762] timeout error, dev nullb0, sector 81840 op 0x0:(READ) fl=
ags 0x0 phys_seg 1 prio class 2
> [ 1648.081093] null_blk: rq 000000002eb20dc4 timed out
> [ 1648.081096] timeout error, dev nullb0, sector 440472 op 0x0:(READ) f=
lags 0x0 phys_seg 1 prio class 2
> [ 1648.083492] null_blk: rq 000000002db4026f timed out
> [ 1648.083496] null_blk: rq 00000000db8f8be3 timed out
> [ 1648.083499] null_blk: rq 00000000078a6daf timed out
> [ 1648.083502] null_blk: rq 000000002c1b7c68 timed out
> [ 1648.083505] null_blk: rq 00000000790d87a1 timed out
> [ 1648.083508] null_blk: rq 000000004f48b7de timed out
> [ 1648.083516] null_blk: rq 0000000074a5ff86 timed out
> [ 1648.083518] null_blk: rq 000000000daf10f8 timed out
> [ 1648.083521] null_blk: rq 00000000d54f527e timed out
> [ 1648.083523] null_blk: rq 0000000009dc7bb8 timed out
> [ 1648.083526] null_blk: rq 0000000017e81cd2 timed out
> [ 1648.083529] null_blk: rq 0000000088e83fa2 timed out
> [ 1648.083532] null_blk: rq 000000003c014afe timed out
> [ 1648.083534] null_blk: rq 00000000b7a99358 timed out
> [ 1648.083537] null_blk: rq 00000000d2d80485 timed out
> [ 1648.083539] null_blk: rq 000000008805db58 timed out
> [ 1648.083541] null_blk: rq 000000005c2e8f7a timed out
> [ 1648.083544] null_blk: rq 00000000a33a2f2d timed out
> [ 1648.083546] null_blk: rq 00000000d05bf454 timed out
> [ 1648.083549] null_blk: rq 0000000080cb849f timed out
> [ 1648.083552] null_blk: rq 000000009cbb48e0 timed out
> [ 1648.083555] null_blk: rq 000000009e426689 timed out
> [ 1648.083558] null_blk: rq 000000003705d117 timed out
> [ 1648.083561] null_blk: rq 0000000010bc80b4 timed out
> [ 1648.083563] null_blk: rq 000000004da816da timed out
> [ 1648.083566] null_blk: rq 0000000081ceaf3f timed out
> [ 1648.083568] null_blk: rq 00000000fb1e808e timed out
> [ 1648.083570] null_blk: rq 000000006baf39c2 timed out
> [ 1648.083573] null_blk: rq 00000000241e851f timed out
> [ 1648.083575] null_blk: rq 00000000a7b7ff27 timed out
> [ 1648.083577] null_blk: rq 0000000092e37377 timed out
> [ 1648.083580] null_blk: rq 00000000a2b070cd timed out
> [ 1648.083583] null_blk: rq 00000000a2c63d6f timed out
> [ 1648.083585] null_blk: rq 00000000b775711d timed out
> [ 1648.083588] null_blk: rq 000000000bfe50e6 timed out
> [ 1648.083590] null_blk: rq 000000005c0b7039 timed out
> [ 1648.083593] null_blk: rq 00000000af60d454 timed out
> [ 1648.083595] null_blk: rq 00000000d2a38d75 timed out
> [ 1648.083598] null_blk: rq 0000000000ae81a8 timed out
> [ 1648.083601] null_blk: rq 000000001974c62a timed out
> [ 1648.083603] null_blk: rq 000000002aaf80e6 timed out
> [ 1648.083605] null_blk: rq 00000000bcdf1c85 timed out
> [ 1648.083608] null_blk: rq 000000008b5d9eb6 timed out
> [ 1648.083610] null_blk: rq 0000000066fcf345 timed out
> [ 1648.083613] null_blk: rq 0000000067dc1221 timed out
> [ 1648.083615] null_blk: rq 0000000088e78508 timed out
> [ 1648.083618] null_blk: rq 000000009d1352eb timed out
> [ 1648.083620] null_blk: rq 00000000a7019839 timed out
> [ 1648.083622] null_blk: rq 00000000f5756a31 timed out
> [ 1648.083625] null_blk: rq 00000000841b16a6 timed out
> [ 1648.083627] null_blk: rq 0000000082fa3e11 timed out
> [ 1648.083630] null_blk: rq 00000000794e9904 timed out
> [ 1648.083632] null_blk: rq 00000000c3bcf5d1 timed out
> [ 1648.094395] blk_sync_queue 230
> [ 1648.094400] blk_sync_queue 232
> [ 1648.094402] blk_sync_queue 234
> [ 1648.096130] blk_sync_queue 230
> [ 1648.096133] blk_sync_queue 232
> [ 1648.096135] blk_sync_queue 234
> NAME    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
> sda       8:0    0   50G  0 disk=20
> =E2=94=9C=E2=94=80sda1    8:1    0    1G  0 part /boot
> =E2=94=94=E2=94=80sda2    8:2    0   49G  0 part /home
> sdb       8:16   0  100G  0 disk /mnt/data
> sr0      11:0    1 1024M  0 rom =20
> zram0   251:0    0    8G  0 disk [SWAP]
> ---
>  drivers/block/null_blk/main.c     | 90 +++++++++++++++++++++++++++++--
>  drivers/block/null_blk/null_blk.h | 10 ++++
>  2 files changed, 97 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/mai=
n.c
> index 1f154f92f4c2..52db6b99b448 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -77,6 +77,10 @@ enum {
>  	NULL_IRQ_TIMER		=3D 2,
>  };
> =20
> +static unsigned int g_rq_abort_limit =3D 5;
> +module_param_named(rq_abort_limit, g_rq_abort_limit, uint, 0644);
> +MODULE_PARM_DESC(rq_abort_limit, "request timeout teardown limit. Defa=
ult:5");

Number of request timeout to trigger device teardown ?

That would a lot clearer in my opinion.

> +
>  static bool g_virt_boundary =3D false;
>  module_param_named(virt_boundary, g_virt_boundary, bool, 0444);
>  MODULE_PARM_DESC(virt_boundary, "Require a virtual boundary for the de=
vice. Default: False");
> @@ -247,6 +251,7 @@ static void null_del_dev(struct nullb *nullb);
>  static int null_add_dev(struct nullb_device *dev);
>  static struct nullb *null_find_dev_by_name(const char *name);
>  static void null_free_device_storage(struct nullb_device *dev, bool is=
_cache);
> +static void null_destroy_dev(struct nullb *nullb);
> =20
>  static inline struct nullb_device *to_nullb_device(struct config_item =
*item)
>  {
> @@ -578,6 +583,18 @@ config_item *nullb_group_make_item(struct config_g=
roup *group, const char *name)
>  {
>  	struct nullb_device *dev;
> =20
> +	if (g_rq_abort_limit) {
> +		/*
> +		 * abort_on_timeout removes the null_blk and resources. When

...the null_blk device and its resources. When the null_blk device is
created using configfs, ...

The remaining of the sentence does not parse at all.

> +		 * null_blk is created using configfs entry by user we will also
> +		 * need to cleanup the those entries when abort_on_timeout is set
> +		 * from null_abort_work() and that we shold not do it, since
> +		 * manupulating user's entries from kernel can create confusion,
> +		 * so just don't allow it.
> +		 */
> +		pr_err("don't use g_abort_on_timeout with configfs entries\n");
> +		return ERR_PTR(-EINVAL);
> +	}
>  	if (null_find_dev_by_name(name))
>  		return ERR_PTR(-EEXIST);
> =20
> @@ -614,7 +631,7 @@ static ssize_t memb_group_features_show(struct conf=
ig_item *item, char *page)
>  			"poll_queues,power,queue_mode,shared_tag_bitmap,size,"
>  			"submit_queues,use_per_node_hctx,virt_boundary,zoned,"
>  			"zone_capacity,zone_max_active,zone_max_open,"
> -			"zone_nr_conv,zone_size\n");
> +			"zone_nr_conv,zone_size,abort_on_timeout,rq_abort_limit\n");

Where is abort_on_timeout defined ? Nowhere to be seen. Does this patch
even compile ? Also, assuming this is a boolean, why introduce it ?
Wouldn't using "rq_abort_limit > 0" be equivalent ?

>  }
> =20
>  CONFIGFS_ATTR_RO(memb_group_, features);
> @@ -1609,10 +1626,60 @@ static int null_poll(struct blk_mq_hw_ctx *hctx=
, struct io_comp_batch *iob)
>  	return nr;
>  }
> =20
> +static bool null_cancel_request(struct request *rq, void *data)
> +{
> +	struct nullb_cmd *cmd =3D blk_mq_rq_to_pdu(rq);
> +
> +	/*
> +	 * Keep it simple and set the timeout error since we've been schedule
> +	 * from timeout handler afterall.
> +	 */
> +	cmd->error =3D BLK_STS_TIMEOUT;
> +	if (blk_mq_request_started(rq) && !blk_mq_request_completed(rq))
> +		blk_mq_complete_request(rq);
> +	return true;
> +}
> +
> +static void null_abort_work(struct work_struct *w)
> +{
> +	struct nullb *nullb =3D container_of(w, struct nullb, abort_work);
> +
> +	mutex_lock(&lock);
> +	if (!nullb || !nullb->dev)
> +		goto unlock;
> +
> +	/*
> +	 * To make sure that null_handle_cmd() callers are not in progress fr=
om
> +	 * null_queue_rq()/null_submit_bio() when we are stopping nullb, we
> +	 * quiece the block layer request queue and engage in teardown sequen=
ce.
> +	 */
> +	blk_freeze_queue_start(nullb->q);
> +	blk_mq_quiesce_queue(nullb->q);
> +	/*
> +	 * We already ensured that submit_bio() will not add any plugging by
> +	 * quiescing so it is safe to sync queue now.
> +	 */
> +	blk_sync_queue(nullb->q);
> +	blk_mq_tagset_busy_iter(nullb->tag_set, null_cancel_request, nullb);
> +	blk_mq_tagset_wait_completed_request(nullb->tag_set);
> +	/*
> +	 * Unblock any pending dispatch I/Os before we destroy the device.
> +	 * From null_destroy_dev()->del_gendisk() will set GD_DEAD flag
> +	 * causing any new I/O from __bio_queue_enter() to fail with -ENODEV.
> +	 */
> +	blk_mq_unquiesce_queue(nullb->q);
> +
> +	null_destroy_dev(nullb);
> +unlock:
> +	mutex_unlock(&lock);
> +}
> +
>  static enum blk_eh_timer_return null_timeout_rq(struct request *rq)
>  {
>  	struct blk_mq_hw_ctx *hctx =3D rq->mq_hctx;
>  	struct nullb_cmd *cmd =3D blk_mq_rq_to_pdu(rq);
> +	struct nullb *nullb =3D cmd->nq->dev->nullb;
> +	bool fake_timeout_no_abort =3D cmd->fake_timeout && !g_rq_abort_limit=
;
> =20
>  	pr_info("rq %p timed out\n", rq);
> =20
> @@ -1632,9 +1699,23 @@ static enum blk_eh_timer_return null_timeout_rq(=
struct request *rq)
>  	 * Only fake timeouts need to execute blk_mq_complete_request() here.
>  	 */
>  	cmd->error =3D BLK_STS_TIMEOUT;
> -	if (cmd->fake_timeout || hctx->type =3D=3D HCTX_TYPE_POLL)
> +	if (fake_timeout_no_abort || hctx->type =3D=3D HCTX_TYPE_POLL) {
>  		blk_mq_complete_request(rq);
> -	return BLK_EH_DONE;
> +		return BLK_EH_DONE;
> +	}
> +
> +	if (atomic_dec_return(&nullb->rq_abort_count) !=3D 0) {
> +		blk_mq_complete_request(rq);
> +		return BLK_EH_DONE;
> +	}
> +
> +	if (!flush_work(&nullb->abort_work))
> +		queue_work(system_highpri_wq, &nullb->abort_work);
> +	/*
> +	 * null_abort_work() will take care of completing all the requests
> +	 * including timed out one.
> +	 */
> +	return BLK_EH_RESET_TIMER;
>  }
> =20
>  static blk_status_t null_queue_rq(struct blk_mq_hw_ctx *hctx,
> @@ -2124,6 +2205,9 @@ static int null_add_dev(struct nullb_device *dev)
>  	if (rv)
>  		goto out_ida_free;
> =20
> +	INIT_WORK(&nullb->abort_work, null_abort_work);
> +	atomic_set(&nullb->rq_abort_count, g_rq_abort_limit);
> +
>  	mutex_lock(&lock);
>  	list_add_tail(&nullb->list, &nullb_list);
>  	mutex_unlock(&lock);
> diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk=
/null_blk.h
> index 94ff68052b1e..d7f5d3161908 100644
> --- a/drivers/block/null_blk/null_blk.h
> +++ b/drivers/block/null_blk/null_blk.h
> @@ -133,6 +133,16 @@ struct nullb {
> =20
>  	struct nullb_queue *queues;
>  	unsigned int nr_queues;
> +	/*
> +	 * null_blk request timeout teardown limit when device is in the
> +	 * stable state, i.e. once this limit is reached issue
> +	 * null_abort_work() to teardown the device from block lyaer
> +	 * request timeout callback and cleanup resources such as
> +	 * memory and pathname.

s/issue/execute
s/lyaer/layer

But I think this can be simplified to something like:

/*
 * Number of requests timeout failures allowed before trigerring
 * a device teardown from the block layer request timeout callback.
 */

> +	 */
> +	atomic_t rq_abort_count;
> +	/* tear down work to be scheduled from block layer request handler */

This comment is not really useful.

> +	struct work_struct abort_work;
>  	char disk_name[DISK_NAME_LEN];
>  };
> =20

--=20
Damien Le Moal
Western Digital Research

