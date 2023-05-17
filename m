Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C428706815
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 14:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbjEQM2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 08:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbjEQM2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 08:28:01 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9733110;
        Wed, 17 May 2023 05:27:59 -0700 (PDT)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 93F7C61E4052B;
        Wed, 17 May 2023 14:27:45 +0200 (CEST)
Message-ID: <506df7b0-6ffb-c829-0c82-89a52f0b0892@molgen.mpg.de>
Date:   Wed, 17 May 2023 14:27:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] Bluetooth: hci_qca: Add support for Qualcomm Bluetooth
 SoC QCA2066
To:     Tim Jiang <quic_tjiang@quicinc.com>
Cc:     marcel@holtmann.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Hemant Gupta <quic_hemantg@quicinc.com>, mka@chromium.org
References: <20230516104102.30775-1-quic_tjiang@quicinc.com>
 <3ef9259f-f778-d18c-6fc6-97aab9e9f9fc@molgen.mpg.de>
 <d3582e14e5204a7895ce34bcbf994533@quicinc.com>
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <d3582e14e5204a7895ce34bcbf994533@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Tim,


Am 17.05.23 um 04:46 schrieb Tim Jiang (QUIC):
> Paul :
>    Thanks for comments, please see inline comments.

Thank you for your reply. (It’d be great, if you used an email client, 
that can properly quote/cite like Mozilla Thunderbird.)

> -----Original Message-----
> From: Paul Menzel <pmenzel@molgen.mpg.de>
> Sent: Tuesday, May 16, 2023 7:00 PM

> Am 16.05.23 um 12:41 schrieb Tim Jiang:
>> This patch adds support for QCA2066 firmware patch and nvm downloading.
> 
> Could you please elaborate, what new features are needed for this as you add common functions?
> 
> Please document the datasheet.
> [Tim] no new feature, only support new chip qca2066 btfw downloading

As I wrote, you add common functions like `qca_read_fw_board_id()`, 
which were not required before. So please elaborate in the commit message.

>> Signed-off-by: Tim Jiang <quic_tjiang@quicinc.com>
>> ---
>>    drivers/bluetooth/btqca.c   | 77 ++++++++++++++++++++++++++++++++++++-
>>    drivers/bluetooth/btqca.h   |  4 ++
>>    drivers/bluetooth/hci_qca.c |  8 +++-
>>    3 files changed, 87 insertions(+), 2 deletions(-)

[…]

>> @@ -574,6 +616,30 @@ int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdaddr)
>>    }
>>    EXPORT_SYMBOL_GPL(qca_set_bdaddr_rome);
>>    
>> +static void qca_generate_nvm_name(struct hci_dev *hdev, char *fwname,
>> +		   size_t max_size, struct qca_btsoc_version ver, u16 bid) {
>> +	u8 rom_ver = 0;
>> +	u32 soc_ver;
> 
> Any reason to fix the size of the variables?
> [Tim] sorry , I does not got your point

Why can’t you simply use `unsigned int` [1]?

[…]

>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index 1b064504b388..ec24ce451568 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -1729,7 +1729,7 @@ static int qca_setup(struct hci_uart *hu)
>>    	bt_dev_info(hdev, "setting up %s",
>>    		qca_is_wcn399x(soc_type) ? "wcn399x" :
>>    		(soc_type == QCA_WCN6750) ? "wcn6750" :
>> -		(soc_type == QCA_WCN6855) ? "wcn6855" : "ROME/QCA6390");
>> +		(soc_type == QCA_WCN6855) ? "wcn6855" : "ROME/QCA6390/QCA2066");
>>    
>>    	qca->memdump_state = QCA_MEMDUMP_IDLE;
>>    
>> @@ -1874,6 +1874,11 @@ static const struct qca_device_data qca_soc_data_qca6390 __maybe_unused = {
>>    	.num_vregs = 0,
>>    };
>>    
>> +static const struct qca_device_data qca_soc_data_qca2066 = {
>> +	.soc_type = QCA_QCA2066,
>> +	.num_vregs = 0,
>> +};
>> +
>>    static const struct qca_device_data qca_soc_data_wcn6750 __maybe_unused = {
>>    	.soc_type = QCA_WCN6750,
>>    	.vregs = (struct qca_vreg []) {
>> @@ -2364,6 +2369,7 @@ static const struct of_device_id qca_bluetooth_of_match[] = {
>>    	{ .compatible = "qcom,wcn3998-bt", .data = &qca_soc_data_wcn3998},
>>    	{ .compatible = "qcom,wcn6750-bt", .data = &qca_soc_data_wcn6750},
>>    	{ .compatible = "qcom,wcn6855-bt", .data = &qca_soc_data_wcn6855},
>> +	{ .compatible = "qcom,qca2066-bt", .data = &qca_soc_data_qca2066},
> 
> Sort it?
> [Tim] it have been sorted or please guide me how to sort it ?

Sort it lexicographically, that means, q goes before w.

>>    	{ /* sentinel */ }
>>    };
>>    MODULE_DEVICE_TABLE(of, qca_bluetooth_of_match);


Kind regards,

Paul
