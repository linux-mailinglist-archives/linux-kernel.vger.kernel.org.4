Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDBA6DF334
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 13:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjDLL0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 07:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjDLL0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:26:37 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500677AB5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 04:26:16 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230412112608euoutp01a509cd0d3406b332c0acf6e442061394~VLFJ_5b9S2723027230euoutp01S
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:26:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230412112608euoutp01a509cd0d3406b332c0acf6e442061394~VLFJ_5b9S2723027230euoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681298768;
        bh=keU/PZNlHgTrwT/tP8Uy4/uf0MafzhR5DJmcL+MKuVc=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=E7V3kW7zvHO3ytvKPkvAFfDICRcw+NkvuHPHp9qEo8hhVvspQVrq5OZ0HR/9B7+eq
         d+OfDVD9gy/UbcnACExAngRt6/SH5OyDNa6RL4AmEFToEToswsZxWUzlWjpuC+kKp9
         U2oagFpm82uQ7bjl2L8VGWnFtWVL8IZTVf05vld0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230412112608eucas1p2297927a00298a5294e74c6402cd8baeb~VLFJ1FTqf2337523375eucas1p2N;
        Wed, 12 Apr 2023 11:26:08 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 32.57.10014.05596346; Wed, 12
        Apr 2023 12:26:08 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230412112608eucas1p2e8aa819cf92ccc2bacfe0ff9bfcd7a6f~VLFJVZYxE2356923569eucas1p2L;
        Wed, 12 Apr 2023 11:26:08 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230412112608eusmtrp183df8cf99383f5f4641cdad9f5f7e3a9~VLFJU18MG0262802628eusmtrp1J;
        Wed, 12 Apr 2023 11:26:07 +0000 (GMT)
X-AuditID: cbfec7f5-ba1ff7000000271e-85-64369550db48
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 78.AF.22108.F4596346; Wed, 12
        Apr 2023 12:26:07 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230412112607eusmtip2bd2bf255b81acda70bfe2f078c051948~VLFJJkrF_2902329023eusmtip2c;
        Wed, 12 Apr 2023 11:26:07 +0000 (GMT)
Received: from [106.110.32.65] (106.110.32.65) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 12 Apr 2023 12:26:07 +0100
Message-ID: <ffc82a81-c212-7990-53fb-2f95eb7af2ad@samsung.com>
Date:   Wed, 12 Apr 2023 13:26:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.9.0
Subject: Re: [PATCH] scripts/gdb: use mem instead of core_layout to get the
 module address
To:     <jan.kiszka@siemens.com>, <kbingham@kernel.org>
CC:     <gost.dev@samsung.com>, <linux-kernel@vger.kernel.org>,
        <song@kernel.org>, <mcgrof@kernel.org>
Content-Language: en-US
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <20230412111508.892296-1-p.raghav@samsung.com>
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.110.32.65]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkleLIzCtJLcpLzFFi42LZduznOd2AqWYpBnO2S1vcu3mT2eJU92Ym
        i8u75rBZ3JjwlNHi+PK/bA6sHptWdbJ5bD85icnj8ya5AOYoLpuU1JzMstQifbsEroyOg8sZ
        C54JVlyacI+9gbGLr4uRk0NCwETi7+dl7F2MXBxCAisYJe5+3ATlfGGUuL1vOTOE85lR4tub
        L+wwLWf7TrNBJJYzSvTMfsECV7X41iYWkCohgZ2MEhfOyIPYvAJ2EmfXrGYDsVkEVCXe9B5i
        hogLSpyc+QSsXlQgSqLv9iZWEFtYIEZi5oqfjCC2iICxxIvJx8B6mQVSJA4e28YIYYtL3Hoy
        n6mLkYODTUBLorET7DhOAWuJ76seskKUyEtsfzuHGeJoRYlJN9+zQti1Eqe23GICuVlC4AGH
        xLOFLVAJF4kjXzugbGGJV8e3QH0sI3F6cg8LhF0t8fTGb2aI5hZGif6d69lAjpAA2tx3JgfE
        ZBbQlFi/Sx+i3FHi8PUGZogKPokbbwUhTuOTmLRtOvMERtVZSAExC8ljs5B8MAth6AJGllWM
        4qmlxbnpqcXGeanlesWJucWleel6yfm5mxiBqeX0v+NfdzCuePVR7xAjEwfjIUYJDmYlEd4f
        LqYpQrwpiZVVqUX58UWlOanFhxilOViUxHm1bU8mCwmkJ5akZqemFqQWwWSZODilGpgCVLfN
        FDUWebLirvX9hZFLzR6pu7i+f8/F6Spx6Paf9cICb6td/XT6lUxvlZu23ipkqha4nH5lya39
        uzk/HNh1dYJSveRaAyHlVypN/67qhko1tzf9VSx98fflr6P36+N2XunvkllZwfLRmFOFNdch
        /G1vWmDxU1EOw8exS/7/y/T8U7WP/93LyqqLm+1ufZeuU4gvOswh9Z0r3ftCpGvJvbtTTgW/
        0HLYFsj29hb/RtvfGzhZcurPB601mPhmyrE1h16r9sdNCrZ/8dLHcUnuHgHBe7pPzQuYEnUn
        S+ktap3iWS654HTipMiH0+3irlky5Lyy33nuf5vqyg0y+t9KJrgnyQese3TCZlVDXK0SS3FG
        oqEWc1FxIgC7qCeFnAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRmVeSWpSXmKPExsVy+t/xe7r+U81SDI6fsbS4d/Mms8Wp7s1M
        Fpd3zWGzuDHhKaPF8eV/2RxYPTat6mTz2H5yEpPH501yAcxRejZF+aUlqQoZ+cUltkrRhhZG
        eoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehkdB5czFjwTrLg04R57A2MXXxcjJ4eE
        gInE2b7TbF2MXBxCAksZJU60b2KESMhIbPxylRXCFpb4c62LDcQWEvjIKPHxayaEvZNRYv/n
        GBCbV8BO4uya1WA1LAKqEm96DzFDxAUlTs58wgJiiwpESXw+0MIOYgsLxEjMXPETbJeIgLHE
        i8nHgHo5OJgFUiRa/ulAjLeS2DbjBdgJzALiEreezGcCKWET0JJo7ASbwilgLfF91UOoEk2J
        1u2/2SFseYntb+cwQ1yvKDHp5nuoT2olPv99xjiBUXQWkuNmIdkwC8moWUhGLWBkWcUoklpa
        nJueW2yoV5yYW1yal66XnJ+7iREYj9uO/dy8g3Heq496hxiZOBgPMUpwMCuJ8P5wMU0R4k1J
        rKxKLcqPLyrNSS0+xGgKDKGJzFKiyfnAhJBXEm9oZmBqaGJmaWBqaWasJM7rWdCRKCSQnliS
        mp2aWpBaBNPHxMEp1cBkJvzYbuuTT75rmzIWHnZLtcpbGSCf7/7t6mOG49natrWuE+6wtFda
        eX9997Ce+3R62gfGQzIpe92y2tL7d787PkVstvHcwHsLuCf6uVx9nqZssuHIjGV7LrDOPMNu
        +rph9aO3/kozAt/3/fY0DFhkdi4gODmLN7o+oNHM105G5HLcjZTnT08dPfhb81zxHL15wu9S
        hL9stS3fsfIqj1Kadvzhw8VXig4ZqwlHHpuz/Z6/svt6s/cHNAr1P33TPqec2qDkkbRJ/tTk
        DL+Jr+R2usz6dcZ0w6dXxYv/9nGmayyadPZMa3Lwv1nTl2s0aq/cG7HpoYxhih/nyeDyv0/L
        gxfPrH2xIaeoL/7thw4ZJZbijERDLeai4kQAYEFAqVADAAA=
X-CMS-MailID: 20230412112608eucas1p2e8aa819cf92ccc2bacfe0ff9bfcd7a6f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230412112608eucas1p2e8aa819cf92ccc2bacfe0ff9bfcd7a6f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230412112608eucas1p2e8aa819cf92ccc2bacfe0ff9bfcd7a6f
References: <20230412111508.892296-1-p.raghav@samsung.com>
        <CGME20230412112608eucas1p2e8aa819cf92ccc2bacfe0ff9bfcd7a6f@eucas1p2.samsung.com>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-12 13:15, Pankaj Raghav wrote:
> commit ac3b43283923 ("module: replace module_layout with module_memory")
> changed the struct module data structure from module_layout to
> module_memory. The core_layout member which is used while loading
> modules are not available anymore leading to the following error while
> running gdb:
> 
> (gdb) lx-symbols
> loading vmlinux
> Python Exception <class 'gdb.error'>: There is no member named core_layout.
> Error occurred in Python: There is no member named core_layout.
> 
> Replace core_layout with its new counterpart mem[MOD_TEXT].
> 
> Fixes: ac3b43283923 ("module: replace module_layout with module_memory")
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---

I had one question:
- Is there a way to import enum? I currently hard code 0 but it will better if we can
use the MOD_TEXT enum instead.

>  scripts/gdb/linux/modules.py | 2 +-
>  scripts/gdb/linux/symbols.py | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/gdb/linux/modules.py b/scripts/gdb/linux/modules.py
> index 441b23239896..6ec51e913070 100644
> --- a/scripts/gdb/linux/modules.py
> +++ b/scripts/gdb/linux/modules.py
> @@ -73,7 +73,7 @@ class LxLsmod(gdb.Command):
>                  "        " if utils.get_long_type().sizeof == 8 else ""))
>  
>          for module in module_list():
> -            layout = module['core_layout']
> +            layout = module['mem'][0]
>              gdb.write("{address} {name:<19} {size:>8}  {ref}".format(
>                  address=str(layout['base']).split()[0],
>                  name=module['name'].string(),
> diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
> index dc07b6d12e30..3a7976401e00 100644
> --- a/scripts/gdb/linux/symbols.py
> +++ b/scripts/gdb/linux/symbols.py
> @@ -109,7 +109,7 @@ lx-symbols command."""
>  
>      def load_module_symbols(self, module):
>          module_name = module['name'].string()
> -        module_addr = str(module['core_layout']['base']).split()[0]
> +        module_addr = str(module['mem'][0]['base']).split()[0]
>  
>          module_file = self._get_module_file(module_name)
>          if not module_file and not self.module_files_updated:
