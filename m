Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25FC56D442B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 14:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbjDCMNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 08:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjDCMN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 08:13:29 -0400
X-Greylist: delayed 1082 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 03 Apr 2023 05:13:27 PDT
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id D6C4A10243;
        Mon,  3 Apr 2023 05:13:26 -0700 (PDT)
Received: from [172.30.38.104] (unknown [42.101.60.222])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id 439D018002B644;
        Mon,  3 Apr 2023 19:47:08 +0800 (CST)
Message-ID: <03265187-6336-9b1f-ea0d-ecbc3c8546f2@nfschina.com>
Date:   Mon, 3 Apr 2023 19:47:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] mmc: core: remove unnecessary (void*) conversions
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     adrian.hunter@intel.com, quic_sayalil@quicinc.com,
        quic_luliang@quicinc.com, m.szyprowski@samsung.com,
        wsa+renesas@sang-engineering.com, yebin10@huawei.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, liqiong@nfschina.com
Content-Language: en-US
X-MD-Sfrom: yuzhe@nfschina.com
X-MD-SrcIP: 42.101.60.222
From:   Yu Zhe <yuzhe@nfschina.com>
In-Reply-To: <CAPDyKFrVuQwLfQZKx9x3PNKTYctWi7=e=vnUsdJgJLJ6=1o2iA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.3 required=5.0 tests=RDNS_NONE,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Tue, 28 Mar 2023 at 05:11, Yu Zhe <yuzhe@nfschina.com> wrote:
>> Pointer variables of void * type do not require type cast.
>>
>> Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
>> Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Did Marek give his reviewed-by tag offlist? I couldn't find his reply,
> just to make sure this is correct?
>
> Kind regards
> Uffe


Sorry, it may be a misuse of "reviewed-by" tag,  "Marek Szyprowski" gave the error
report at the previous patch, so, i put the name at reviewed-by tag.

>
>> ---
>>   drivers/mmc/core/debugfs.c  | 2 +-
>>   drivers/mmc/core/mmc_test.c | 6 +++---
>>   2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
>> index fe6808771bc7..2c97b94aab23 100644
>> --- a/drivers/mmc/core/debugfs.c
>> +++ b/drivers/mmc/core/debugfs.c
>> @@ -246,7 +246,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(mmc_err_state, mmc_err_state_get, NULL, "%llu\n");
>>
>>   static int mmc_err_stats_show(struct seq_file *file, void *data)
>>   {
>> -       struct mmc_host *host = (struct mmc_host *)file->private;
>> +       struct mmc_host *host = file->private;
>>          const char *desc[MMC_ERR_MAX] = {
>>                  [MMC_ERR_CMD_TIMEOUT] = "Command Timeout Occurred",
>>                  [MMC_ERR_CMD_CRC] = "Command CRC Errors Occurred",
>> diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
>> index 156d34b2ed4d..0f6a563103fd 100644
>> --- a/drivers/mmc/core/mmc_test.c
>> +++ b/drivers/mmc/core/mmc_test.c
>> @@ -3045,7 +3045,7 @@ static LIST_HEAD(mmc_test_file_test);
>>
>>   static int mtf_test_show(struct seq_file *sf, void *data)
>>   {
>> -       struct mmc_card *card = (struct mmc_card *)sf->private;
>> +       struct mmc_card *card = sf->private;
>>          struct mmc_test_general_result *gr;
>>
>>          mutex_lock(&mmc_test_lock);
>> @@ -3079,8 +3079,8 @@ static int mtf_test_open(struct inode *inode, struct file *file)
>>   static ssize_t mtf_test_write(struct file *file, const char __user *buf,
>>          size_t count, loff_t *pos)
>>   {
>> -       struct seq_file *sf = (struct seq_file *)file->private_data;
>> -       struct mmc_card *card = (struct mmc_card *)sf->private;
>> +       struct seq_file *sf = file->private_data;
>> +       struct mmc_card *card = sf->private;
>>          struct mmc_test_card *test;
>>          long testcase;
>>          int ret;
>> --
>> 2.11.0
>>
