Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD6F6D5287
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 22:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbjDCUfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 16:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjDCUfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 16:35:15 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89D2109;
        Mon,  3 Apr 2023 13:35:13 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 333ETv8c027587;
        Mon, 3 Apr 2023 20:34:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=0y+2yRD4cbbBvfAfR4jDn5m56JlDgK3Zu4rz5RmpMDc=;
 b=TBx5o1Z3wlJeHYeIDopr74ZHYBscCJqm6ruu+YmXrJbjN655rFBH+FwazJrNSo53B8tN
 wh01u7GAfUhJH0IPABcwbBdw+SYaXDn7UkYGfhM1+OBnzafultaSMC8U1cZ+TxJZimII
 X22iTQET77/UaXBqduiADHiHTSg3mRioA0Fasban5br5UibogQq6H2h5gXZQmbP0U+QS
 EYvFhKEM2dGzhUWz7XeyvBswzpaOqxTGfY9JA63kkbBwZdLlr5om3/+O9jr29aiYs8o1
 rW4eBrNdg6SyHogE8HjC1qKBn2y5T9AStpJ8jUjpzd1UzN/hh/3y6p9fyvPsv+DLcn4F LQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pr0kx0ud2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Apr 2023 20:34:59 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 333KYvNx002200
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 3 Apr 2023 20:34:57 GMT
Received: from [10.134.65.165] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 3 Apr 2023
 13:34:54 -0700
Message-ID: <b4a96d07-d788-93b4-eb23-217dce1fb56e@quicinc.com>
Date:   Mon, 3 Apr 2023 13:34:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v11 08/26] gunyah: rsc_mgr: Add resource manager RPC core
Content-Language: en-US
To:     Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
CC:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230304010632.2127470-1-quic_eberman@quicinc.com>
 <20230304010632.2127470-9-quic_eberman@quicinc.com>
 <02ab8928-a34a-f034-d123-b0319edf1c6f@linaro.org>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <02ab8928-a34a-f034-d123-b0319edf1c6f@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yrNk7GRagd8QvSMzmubOPqYtnBtpFnPH
X-Proofpoint-ORIG-GUID: yrNk7GRagd8QvSMzmubOPqYtnBtpFnPH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_16,2023-04-03_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1015 lowpriorityscore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304030160
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/31/2023 7:25 AM, Alex Elder wrote:
> On 3/3/23 7:06 PM, Elliot Berman wrote:
>> The resource manager is a special virtual machine which is always
>> running on a Gunyah system. It provides APIs for creating and destroying
>> VMs, secure memory management, sharing/lending of memory between VMs,
>> and setup of inter-VM communication. Calls to the resource manager are
>> made via message queues.
>>
>> This patch implements the basic probing and RPC mechanism to make those
>> API calls. Request/response calls can be made with gh_rm_call.
>> Drivers can also register to notifications pushed by RM via
>> gh_rm_register_notifier
>>
>> Specific API calls that resource manager supports will be implemented in
>> subsequent patches.
> 
> Mostly very simple issues noted here.    -Alex
> 
>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>> ---
>>   drivers/virt/gunyah/Makefile   |   3 +
>>   drivers/virt/gunyah/rsc_mgr.c  | 688 +++++++++++++++++++++++++++++++++
>>   drivers/virt/gunyah/rsc_mgr.h  |  16 +
>>   include/linux/gunyah_rsc_mgr.h |  21 +
>>   4 files changed, 728 insertions(+)
>>   create mode 100644 drivers/virt/gunyah/rsc_mgr.c
>>   create mode 100644 drivers/virt/gunyah/rsc_mgr.h
>>   create mode 100644 include/linux/gunyah_rsc_mgr.h
>>
>> diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
>> index 34f32110faf9..cc864ff5abbb 100644
>> --- a/drivers/virt/gunyah/Makefile
>> +++ b/drivers/virt/gunyah/Makefile
>> @@ -1,3 +1,6 @@
>>   # SPDX-License-Identifier: GPL-2.0
>>   obj-$(CONFIG_GUNYAH) += gunyah.o
>> +
>> +gunyah_rsc_mgr-y += rsc_mgr.o
>> +obj-$(CONFIG_GUNYAH) += gunyah_rsc_mgr.o
>> diff --git a/drivers/virt/gunyah/rsc_mgr.c 
>> b/drivers/virt/gunyah/rsc_mgr.c
>> new file mode 100644
>> index 000000000000..67813c9a52db
>> --- /dev/null
>> +++ b/drivers/virt/gunyah/rsc_mgr.c
>> @@ -0,0 +1,688 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All 
>> rights reserved.
>> + */
>> +
> 
> . . .
> 
>> +static void gh_rm_try_complete_connection(struct gh_rm *rm)
>> +{
>> +    struct gh_rm_connection *connection = rm->active_rx_connection;
>> +
>> +    if (!connection || connection->fragments_received != 
>> connection->num_fragments)
>> +        return;
>> +
>> +    switch (connection->type) {
>> +    case RM_RPC_TYPE_REPLY:
>> +        complete(&connection->reply.seq_done);
>> +        break;
>> +    case RM_RPC_TYPE_NOTIF:
>> +        schedule_work(&connection->notification.work);
>> +        break;
>> +    default:
>> +        dev_err_ratelimited(rm->dev, "Invalid message type (%d) 
>> received\n",
> 
> s/%d/%u/
> 
>> +                    connection->type);
>> +        gh_rm_abort_connection(rm);
>> +        break;
>> +    }
>> +
>> +    rm->active_rx_connection = NULL;
>> +}
>> +
>> +static void gh_rm_msgq_rx_data(struct mbox_client *cl, void *mssg)
>> +{
>> +    struct gh_rm *rm = container_of(cl, struct gh_rm, msgq_client);
>> +    struct gh_msgq_rx_data *rx_data = mssg;
>> +    size_t msg_size = rx_data->length;
>> +    void *msg = rx_data->data;
>> +    struct gh_rm_rpc_hdr *hdr;
>> +
>> +    if (msg_size < sizeof(*hdr) || msg_size > GH_MSGQ_MAX_MSG_SIZE)
>> +        return;
>> +
>> +    hdr = msg;
>> +    if (hdr->api != RM_RPC_API) {
>> +        dev_err(rm->dev, "Unknown RM RPC API version: %x\n", hdr->api);
>> +        return;
>> +    }
>> +
>> +    switch (FIELD_GET(RM_RPC_TYPE_MASK, hdr->type)) {
>> +    case RM_RPC_TYPE_NOTIF:
>> +        gh_rm_process_notif(rm, msg, msg_size);
>> +        break;
>> +    case RM_RPC_TYPE_REPLY:
>> +        gh_rm_process_rply(rm, msg, msg_size);
>> +        break;
>> +    case RM_RPC_TYPE_CONTINUATION:
>> +        gh_rm_process_cont(rm, rm->active_rx_connection, msg, msg_size);
>> +        break;
>> +    default:
>> +        dev_err(rm->dev, "Invalid message type (%lu) received\n",
>> +            FIELD_GET(RM_RPC_TYPE_MASK, hdr->type));
>> +        return;
>> +    }
>> +
>> +    gh_rm_try_complete_connection(rm);
>> +}
>> +
>> +static void gh_rm_msgq_tx_done(struct mbox_client *cl, void *mssg, 
>> int r)
>> +{
>> +    struct gh_rm *rm = container_of(cl, struct gh_rm, msgq_client);
>> +
>> +    kmem_cache_free(rm->cache, mssg);
>> +    rm->last_tx_ret = r;
>> +}
>> +
>> +static int gh_rm_send_request(struct gh_rm *rm, u32 message_id,
>> +                  const void *req_buff, size_t req_buf_size,
>> +                  struct gh_rm_connection *connection)
>> +{
>> +    size_t buf_size_remaining = req_buf_size;
>> +    const void *req_buf_curr = req_buff;
>> +    struct gh_msgq_tx_data *msg;
>> +    struct gh_rm_rpc_hdr *hdr, hdr_template;
>> +    u32 cont_fragments = 0;
>> +    size_t payload_size;
>> +    void *payload;
>> +    int ret;
>> +
>> +    if (req_buf_size > GH_RM_MAX_NUM_FRAGMENTS * GH_RM_MAX_MSG_SIZE) {
>> +        dev_warn(rm->dev, "Limit exceeded for the number of 
>> fragments: %u\n",
>> +            cont_fragments);
> 
> You are printing the value of cont_fragments here when it's just zero.
> 
>> +        dump_stack();
>> +        return -E2BIG;
>> +    }
>> +
> 
> Move the computation of cont_fragments prior to the block above.
> You could use a ?: statement to assign it.
> 
>> +    if (req_buf_size)
>> +        cont_fragments = (req_buf_size - 1) / GH_RM_MAX_MSG_SIZE;
>> +
>> +    hdr_template.api = RM_RPC_API;
>> +    hdr_template.type = FIELD_PREP(RM_RPC_TYPE_MASK, 
>> RM_RPC_TYPE_REQUEST) |
>> +            FIELD_PREP(RM_RPC_FRAGMENTS_MASK, cont_fragments);
> 
> The line above should be indented further.
> 
>> +    hdr_template.seq = cpu_to_le16(connection->reply.seq);
>> +    hdr_template.msg_id = cpu_to_le32(message_id);
>> +
>> +    ret = mutex_lock_interruptible(&rm->send_lock);
>> +    if (ret)
>> +        return ret;
>> +
>> +    /* Consider also the 'request' packet for the loop count */
> 
> I don't think the comment above is helpful.
> 
>> +    do {
>> +        msg = kmem_cache_zalloc(rm->cache, GFP_KERNEL);
>> +        if (!msg) {
>> +            ret = -ENOMEM;
>> +            goto out;
>> +        }
>> +
>> +        /* Fill header */
>> +        hdr = (struct gh_rm_rpc_hdr *)msg->data;
> 
> I personally would prefer &msg->data[0] in this case.
> 
>> +        *hdr = hdr_template;
>> +
>> +        /* Copy payload */
>> +        payload = hdr + 1;
> 
> I think I might have suggested using "hdr + 1" here.
> 
> Elsewhere you use something like:
>      payload = (char *)hdr + sizeof(hdr);
> or something similar.  I suggest you choose one approach and use
> it consistently througout the driver.  Either is fine, but I
> have a slight preference for the "hdr + 1" way.
> 

I think you might be referencing the memcpy in 
gh_rm_init_connection_payload. In the gh_rm_init_connection_payload, 
hdr_size is not fixed: for notifications, it's just the RPC header. For 
responses, there is the RPC header + the "RM error code". To be able to 
re-use same header processing, I'd have to do byte arithmetic rather 
than the "hdr + 1" way. I also prefer the "hdr + 1" way, but if I am 
going to be consistent, need to stick with byte arithmetic.

>> +        payload_size = min(buf_size_remaining, GH_RM_MAX_MSG_SIZE);
>> +        memcpy(payload, req_buf_curr, payload_size);
>> +        req_buf_curr += payload_size;
>> +        buf_size_remaining -= payload_size;
>> +
>> +        /* Force the last fragment to immediately alert the receiver */
>> +        msg->push = !buf_size_remaining;
>> +        msg->length = sizeof(*hdr) + payload_size;
>> +
>> +        ret = mbox_send_message(gh_msgq_chan(&rm->msgq), msg);
>> +        if (ret < 0) {
>> +            kmem_cache_free(rm->cache, msg);
>> +            break;
>> +        }
>> +
>> +        if (rm->last_tx_ret) {
>> +            ret = rm->last_tx_ret;
>> +            break;
>> +        }
>> +
>> +        hdr_template.type = FIELD_PREP(RM_RPC_TYPE_MASK, 
>> RM_RPC_TYPE_CONTINUATION) |
>> +                    FIELD_PREP(RM_RPC_FRAGMENTS_MASK, cont_fragments);
>> +    } while (buf_size_remaining);
>> +
>> +out:
>> +    mutex_unlock(&rm->send_lock);
>> +    return ret < 0 ? ret : 0;
>> +}
>> +
>> +/**
>> + * gh_rm_call: Achieve request-response type communication with RPC
>> + * @rm: Pointer to Gunyah resource manager internal data
>> + * @message_id: The RM RPC message-id
>> + * @req_buff: Request buffer that contains the payload
>> + * @req_buf_size: Total size of the payload
>> + * @resp_buf: Pointer to a response buffer
>> + * @resp_buf_size: Size of the response buffer
>> + *
>> + * Make a request to the RM-VM and wait for reply back. For a successful
> 
> I think you could just say "to the RM and wait"...
> 
> Overall I suggest using "RM" or "RM VM" consistently when you talk
> about the Resource Manager.  This is the only place I see "RM-VM".
> 
>> + * response, the function returns the payload. The size of the 
>> payload is set in
>> + * resp_buf_size. The resp_buf should be freed by the caller when 0 
>> is returned
> 
> s/should/must/
> 
>> + * and resp_buf_size != 0.
>> + *
>> + * req_buff should be not NULL for req_buf_size >0. If req_buf_size 
>> == 0,
>> + * req_buff *can* be NULL and no additional payload is sent.
> 
> I'd say use "buf" or "buff" but not both in your naming
> convention.
> 

Not intentional -- will make it consistent.

>> + *
>> + * Context: Process context. Will sleep waiting for reply.
>> + * Return: 0 on success. <0 if error.
>> + */
>> +int gh_rm_call(struct gh_rm *rm, u32 message_id, void *req_buff, 
>> size_t req_buf_size,
>> +        void **resp_buf, size_t *resp_buf_size)
> 
> I suspect you could define the request buffer as a pointer to const;
> can you?
> 

I can!

>> +{
>> +    struct gh_rm_connection *connection;
>> +    u32 seq_id;
>> +    int ret;
>> +
>> +    /* message_id 0 is reserved. req_buf_size implies req_buf is not 
>> NULL */
>> +    if (!message_id || (!req_buff && req_buf_size) || !rm)
> 
> If you're going to check for a null RM pointer, I'd check it first.
> 
>> +        return -EINVAL;
>> +
>> +
>> +    connection = kzalloc(sizeof(*connection), GFP_KERNEL);
>> +    if (!connection)
>> +        return -ENOMEM;
>> +
>> +    connection->type = RM_RPC_TYPE_REPLY;
>> +    connection->msg_id = cpu_to_le32(message_id);
>> +
>> +    init_completion(&connection->reply.seq_done);
> 
> . . .
> 
>> diff --git a/include/linux/gunyah_rsc_mgr.h 
>> b/include/linux/gunyah_rsc_mgr.h
>> new file mode 100644
>> index 000000000000..deca9b3da541
>> --- /dev/null
>> +++ b/include/linux/gunyah_rsc_mgr.h
>> @@ -0,0 +1,21 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All 
>> rights reserved.
>> + */
>> +
>> +#ifndef _GUNYAH_RSC_MGR_H
>> +#define _GUNYAH_RSC_MGR_H
>> +
>> +#include <linux/list.h>
>> +#include <linux/notifier.h>
>> +#include <linux/gunyah.h>
>> +
>> +#define GH_VMID_INVAL    U16_MAX
> 
> Add a tab before U16_MAX; it will line up more nicely
> when you define GH_MEM_HANDLE_INVAL later.
> 
>> +
>> +struct gh_rm;
>> +int gh_rm_notifier_register(struct gh_rm *rm, struct notifier_block 
>> *nb);
>> +int gh_rm_notifier_unregister(struct gh_rm *rm, struct notifier_block 
>> *nb);
>> +struct device *gh_rm_get(struct gh_rm *rm);
>> +void gh_rm_put(struct gh_rm *rm);
>> +
>> +#endif
> 
