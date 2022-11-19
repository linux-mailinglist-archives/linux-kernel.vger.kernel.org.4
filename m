Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A714630C15
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 06:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiKSFU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 00:20:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiKSFUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 00:20:25 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C11C8DA78;
        Fri, 18 Nov 2022 21:20:25 -0800 (PST)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NDhjM6ZM4zFqPy;
        Sat, 19 Nov 2022 13:17:11 +0800 (CST)
Received: from [10.67.109.51] (10.67.109.51) by canpemm500009.china.huawei.com
 (7.192.105.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 19 Nov
 2022 13:20:23 +0800
Message-ID: <225f716c-83af-2534-0c58-20b6d28acdc1@huawei.com>
Date:   Sat, 19 Nov 2022 13:20:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] KEYS: asymmetric: Fix build errors as symbol undefined
To:     <dhowells@redhat.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <David.Woodhouse@intel.com>
CC:     <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <weiyongjun1@huawei.com>,
        <yusongping@huawei.com>
References: <20221115100512.20147-1-hucool.lihua@huawei.com>
From:   "Lihua (lihua, ran)" <hucool.lihua@huawei.com>
In-Reply-To: <20221115100512.20147-1-hucool.lihua@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.51]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping

在 2022/11/15 18:05, Li Hua 写道:
> pkcs7_supply_detached_data is called by x509_key_parser module, but not exported:
>      ERROR: modpost: "pkcs7_supply_detached_data" [crypto/asymmetric_keys/x509_key_parser.ko] undefined!
> 
> Fixes: cfc411e7fff3 ("Move certificate handling to its own directory")
> Signed-off-by: Li Hua <hucool.lihua@huawei.com>
> ---
>   crypto/asymmetric_keys/pkcs7_verify.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/crypto/asymmetric_keys/pkcs7_verify.c b/crypto/asymmetric_keys/pkcs7_verify.c
> index f6321c785714..4fa769c4bcdb 100644
> --- a/crypto/asymmetric_keys/pkcs7_verify.c
> +++ b/crypto/asymmetric_keys/pkcs7_verify.c
> @@ -485,3 +485,4 @@ int pkcs7_supply_detached_data(struct pkcs7_message *pkcs7,
>   	pkcs7->data_len = datalen;
>   	return 0;
>   }
> +EXPORT_SYMBOL_GPL(pkcs7_supply_detached_data);
> 
