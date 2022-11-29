Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188C963CBFA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 00:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbiK2XqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 18:46:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiK2XqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 18:46:06 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9739864A09
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 15:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669765565; x=1701301565;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ycxaYLjYb+ma8DDHfOmlnxZ6kUuyag3iWhXxhAoI4Bs=;
  b=T05DJzx7qmqs2yFmlWJxavzZC45BRaIHjUAj3bv7adUNOPJkWjkDImWa
   H/I97EeVYW8Wv8hg0q2k8DBICidCIzb300O0daPkYxaSaANniDn6u6MZn
   F8qgJ5OzIGByU0SCxAktkGmWZJsJ6FkNbCMbwpn3Cj2MSjZq6tQHTamm9
   JyWfmOxwxcLcXj9Jpn19OL2rV9XVk1cNYZiOIhYDEkxghGVKPCNDAI9dZ
   CpwbiUjzjdeLj6iKPLoWrENI/GQZP5XqK/ILaQHbIcZORpcOvwUQVtrqF
   dHXyrBictNkc4Q1BQBkbBZdawtWWMm6AftDBw73e8FmMnvZJiRqziUw96
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,204,1665417600"; 
   d="scan'208";a="217494473"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2022 07:46:03 +0800
IronPort-SDR: 9jddfW0DA3J987UnI3dsW1iBLKV7+CzkNe3kJXFrPDem81Xya2KtnpkneJUEteLxiIyFbPdaLg
 Tz8COp9r2xA3uhLDC6CgaaMBOzOaJSGlFhWPghb9WIa3iNQ6vPJef9JbKb3UZWTgoIARUZz2EF
 9hgYELVWDNjuELfrNROc4ksfVZNZQdVMRimRr9DeUstDD45a6/nUqR4u7VFfCWrRpZ+YrtCBVI
 +y/B9VDbHvrF5ciLoQ1GPZurz3C2IYJp8PybQyHMOv2Hbqgkd8Zo3zlzwjs7cNffYZnZgCWg+U
 JDk=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Nov 2022 14:58:58 -0800
IronPort-SDR: vpk4pZB6/ze3mZopUACGmM3e3Awz1tthz4oJOw7Bg7vARx+LLvRQUcGA3hm8rM+xT9uqLwd911
 ypcrxrHq1rWFTnYYuOHtPhDS31Oi6z45Dyd2zVHL273ulIXhGYD61lJ++WHtgv5th4nO32OLC5
 SIFXPusYAaFaesIrgfIRtiVJKF5HTv5PqLK7ASJtbnHvIZYNVHxOPZ98RDQUdtSJbPhZbj6PkY
 QsemKkzdW/8+ydVBBori3lj3of69eRltP3YbEovOtjXZ13ReyVqNZYVL5M5J+DI0CQ21pw8cZZ
 7TA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Nov 2022 15:46:02 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NMJrB1TdCz1RvTp
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 15:46:02 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1669765561; x=1672357562; bh=ycxaYLjYb+ma8DDHfOmlnxZ6kUuyag3iWhX
        xhAoI4Bs=; b=qHUBIFsDit9tB+442wqkn8FnslJgjothH93jBEv+p37QzdcVqT7
        JfyO2rDEUbUFU9ySIb6ZZMnZBkjX7o0IfKCBh9VF3scGsxJdsvMdYhmob3Tpcuab
        QG6jHaofPY0hzIb5TbUHsCGPOi6edYL/y4fqu2zn4hilxMkcewsJd7eFcQmVvb7b
        41/WHvDf10VLkoY2+XPdKEsfCgSclP6hWS1nxiADYM69SXCQQsVgN48gtFRUhqDm
        CsGxlhrpkpqISWqICcXfGp/oz1v4MaTTkLG3r0YCNvoZm6NCTsx0miQge60XpbWC
        vDK9OwTwLp1OVSbohBFP1cwtZh8aadUIFVQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id WSGweiWtp961 for <linux-kernel@vger.kernel.org>;
        Tue, 29 Nov 2022 15:46:01 -0800 (PST)
Received: from [10.225.163.66] (unknown [10.225.163.66])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NMJr51fc7z1RvLy;
        Tue, 29 Nov 2022 15:45:56 -0800 (PST)
Message-ID: <b22652ee-9cca-a5b1-e9f1-862ed8f0354d@opensource.wdc.com>
Date:   Wed, 30 Nov 2022 08:45:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v5 10/10] fs: add support for copy file range in zonefs
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, james.smart@broadcom.com, kch@nvidia.com,
        naohiro.aota@wdc.com, jth@kernel.org, viro@zeniv.linux.org.uk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        anuj20.g@samsung.com, joshi.k@samsung.com, p.raghav@samsung.com,
        nitheshshetty@gmail.com, gost.dev@samsung.com
References: <20221123055827.26996-1-nj.shetty@samsung.com>
 <CGME20221123061044epcas5p2ac082a91fc8197821f29e84278b6203c@epcas5p2.samsung.com>
 <20221123055827.26996-11-nj.shetty@samsung.com>
 <729254f8-2468-e694-715e-72bcbef80ff3@opensource.wdc.com>
 <349a4d66-3a9f-a095-005c-1f180c5f3aac@opensource.wdc.com>
 <20221129122232.GC16802@test-zns>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221129122232.GC16802@test-zns>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/22 21:22, Nitesh Shetty wrote:
> Acked. I do see a gap in current zonefs cfr implementation. I will drop this

cfr ?

> implementation for next version. Once we finalize on block copy offload
> implementation, will re-pick this and send with above reviews fixed.
> 
> Thank you,
> Nitesh

Please trim your replies.


-- 
Damien Le Moal
Western Digital Research

