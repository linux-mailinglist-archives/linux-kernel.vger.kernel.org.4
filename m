Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3205364AD07
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 02:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbiLMBak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 20:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233867AbiLMBai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 20:30:38 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4411CFC5;
        Mon, 12 Dec 2022 17:30:37 -0800 (PST)
Received: from dggpemm500007.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NWLRs5rtGzqT5J;
        Tue, 13 Dec 2022 09:26:17 +0800 (CST)
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 13 Dec 2022 09:30:33 +0800
Subject: Re: [PATCH v1] spi: xtensa-xtfpga: Fix a double put() in
 xtfpga_spi_remove()
To:     Mark Brown <broonie@kernel.org>, Max Filippov <jcmvbkbc@gmail.com>
CC:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <linux-xtensa@linux-xtensa.org>, <linux-spi@vger.kernel.org>,
        <yangyingliang@huawei.com>
References: <7946a26c6e53a4158f0f5bad5276d8654fd59415.1670673147.git.christophe.jaillet@wanadoo.fr>
 <CAMo8BfKCv9j-ftKWU+B27g1oHBB_=EZhGBH7qymyVAeF10JcnQ@mail.gmail.com>
 <Y5dKk+uw3UcW2Pu1@sirena.org.uk>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <bdb26ba3-7276-359a-7784-6ec3e35c64de@huawei.com>
Date:   Tue, 13 Dec 2022 09:30:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <Y5dKk+uw3UcW2Pu1@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/12/12 23:36, Mark Brown wrote:
> On Sat, Dec 10, 2022 at 06:48:02AM -0800, Max Filippov wrote:
>> Hi Christophe,
>>
>> On Sat, Dec 10, 2022 at 3:52 AM Christophe JAILLET
>> <christophe.jaillet@wanadoo.fr> wrote:
>>> 'master' is allocated with devm_spi_alloc_master(), there is no need to
>>> put it explicitly in the remove function.
>>>          spi_bitbang_stop(&xspi->bitbang);
>>> -       spi_master_put(master);
>> This put is matching the get in the spi_bitbang_start.
>> It was discussed here:
>> https://lore.kernel.org/linux-spi/CAMo8BfJaD7pG_iutY8jordysjChyzhTpVSqpxXh3QoZsj2QmaQ@mail.gmail.com/
> Probably worth a comment though since it is a bit of a gotcha.  Ideally
> we'd improve this in the bitbang code but that's harder.
Ideally, spi_bitbang_stop() should undo spi_bitbang_start(). shall we 
move spi_master_put() in spi_bitbang_stop() instead of
calling it separately in drivers?

Thanks,
Yang
