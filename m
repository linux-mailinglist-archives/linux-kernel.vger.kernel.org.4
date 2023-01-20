Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81128676167
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 00:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjATXSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 18:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjATXSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 18:18:51 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CAD4216;
        Fri, 20 Jan 2023 15:18:42 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KN3vBP028204;
        Fri, 20 Jan 2023 23:18:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ZufnGe8VdqJtNMmnHqfPr6r+n1ptCZ71g+8OrpOJPaM=;
 b=LoVO91m9z41ZGLHRMn6VYQXHlQP4XUY9exYuS5O39G6L5IcCuZiVTmJIv1EDUUraJ66Y
 VXcKnUMVXev2o9Py17XwbCCX/X9/dL436cgQ33GZFvWjPY6RPPgB55o+MCJu1BKKaKlY
 +QGuCpW6mUAGssNXgfVtQZVHd5zy55ko3EVfp/EgjDbaU7ycLDYmMhwEcyd+0yxvaD5+
 xx5syPFzgZq0eO87iOCZG3CVJ5wZ80Nu0N388uqgzkP62hR+5UC2rCGkFbmP360B0KvQ
 Jp1baLw7R4JOf2W+DY/VE0Ioo9RfIc88yIL8pCsWvWgWg1t7IajBuAvszQ7Kg/Vl3yEg Iw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n70eymmm5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 23:18:24 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30KNINUb029712
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 23:18:23 GMT
Received: from [10.134.67.48] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 20 Jan
 2023 15:18:17 -0800
Message-ID: <2a7bb5f2-1286-b661-659a-a5037150eae8@quicinc.com>
Date:   Fri, 20 Jan 2023 15:18:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
From:   Elliot Berman <quic_eberman@quicinc.com>
Subject: Re: [PATCH v8 10/28] gunyah: rsc_mgr: Add resource manager RPC core
To:     Alex Elder <elder@linaro.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>
CC:     Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Bagas Sanjaya" <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        "Sudeep Holla" <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>
References: <20221219225850.2397345-1-quic_eberman@quicinc.com>
 <20221219225850.2397345-11-quic_eberman@quicinc.com>
 <1f442387-f57f-ad44-0a58-351dfb0a5e81@linaro.org>
Content-Language: en-US
In-Reply-To: <1f442387-f57f-ad44-0a58-351dfb0a5e81@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NpnMeR7p6DMe2zg9fq25XiCTjsSLT-0e
X-Proofpoint-GUID: NpnMeR7p6DMe2zg9fq25XiCTjsSLT-0e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_11,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301200223
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/17/2023 2:33 PM, Alex Elder wrote:
> On 12/19/22 4:58 PM, Elliot Berman wrote:
>> The resource manager is a special virtual machine which is always
>> running on a Gunyah system. It provides APIs for creating and destroying
>> VMs, secure memory management, sharing/lending of memory between VMs,
>> and setup of inter-VM communication. Calls to the resource manager are
>> made via message queues.
> 
> I mentioned in an earlier message that I did a really thorough
> review of this.  Actually I haven't reviewed the interrupt part
> yet, but I'll get to that.  I want to get my comments out now.
> 
> I found one bug, but I'd guess it's not likely to occur (though
> user space can trigger it so it's serious).  You'll see it below.
> 
>> This patch implements the basic probing and RPC mechanism to make those
>> API calls. Request/response calls can be made with gh_rm_call.
>> Drivers can also register to notifications pushed by RM via
>> gh_rm_register_notifier
> 
> Is there a human-readable document that explains the RPC
> protocol and formats?  (It would provide a way to compare
> the implementation with the intended design.)
> 
> Here's what I see:
> 
> It appears that each sent message is delivered exactly once,
> and messages arrive in order and are assumed to be intact.
> 
> A Gunyah message holds a 240 byte maximum payload, while a
> resource manager RPC message (carried in a Gunyah message)
> has a 232 byte maximum payload.
> 
> An RPC "connection" is either a notification message (only
> *from* the resource manager) or a request/response message
> pair sharing the same sequence ID (with the request only
> going *to* the resource manager).  An RPC "connection"
> consists of a single RPC message (of any of the three types)
> followed by 0-62 "fragment" messages, where the payload for
> each message is concatenated by the receiver into a single
> buffer (up to 63 * 232 = 14616 bytes in size).
> 
> An RPC header contains a sequence ID that's unique for
> each active "connection" to the resource manager (and
> ignored for notifications).  It also contains a message
> ID supplied by the user of the resource manager interface
> (e.g., a VM); the message ID in a response must match the
> message ID in its matching request.
> 

This is the correct understanding. There is a document, I will work with 
the right folks to see how we make it available.

>> Specific API calls that resource manager supports will be implemented in
>> subsequent patches.
>>
>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>> ---
>>   MAINTAINERS                    |   2 +-
>>   drivers/virt/gunyah/Kconfig    |  14 +
>>   drivers/virt/gunyah/Makefile   |   3 +
>>   drivers/virt/gunyah/rsc_mgr.c  | 584 +++++++++++++++++++++++++++++++++
>>   drivers/virt/gunyah/rsc_mgr.h  |  36 ++
>>   include/linux/gunyah_rsc_mgr.h |  18 +
>>   6 files changed, 656 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/virt/gunyah/rsc_mgr.c
>>   create mode 100644 drivers/virt/gunyah/rsc_mgr.h
>>   create mode 100644 include/linux/gunyah_rsc_mgr.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 667480bfd387..bb315385e155 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -8944,7 +8944,7 @@ F:    Documentation/virt/gunyah/
>>   F:    arch/arm64/gunyah/
>>   F:    drivers/mailbox/gunyah-msgq.c
>>   F:    drivers/virt/gunyah/
>> -F:    include/linux/gunyah.h
>> +F:    include/linux/gunyah*.h
>>   HABANALABS PCI DRIVER
>>   M:    Oded Gabbay <ogabbay@kernel.org>
>> diff --git a/drivers/virt/gunyah/Kconfig b/drivers/virt/gunyah/Kconfig
>> index 127156a678a6..4a6189dedab2 100644
>> --- a/drivers/virt/gunyah/Kconfig
>> +++ b/drivers/virt/gunyah/Kconfig
>> @@ -10,3 +10,17 @@ config GUNYAH
>>         Say Y/M here to enable the drivers needed to interact in a Gunyah
>>         virtual environment.
>> +
>> +if GUNYAH
>> +config GUNYAH_RESOURCE_MANAGER
> 
> Is Gunyah useful without the resource manager?
> 
> There might be good reasons to have different kernel config
> options for parts of Gunyah (like, perhaps you want to allow
> a *different* resource manager to be used).  But if, overall,
> a component is fundamentally required for Gunyah to operate,
> I don't think it's helpful to configure it separately.
> 
> This comment applies to all your config options.  I won't
> mention it again, but maybe you can consider it, and for
> anything that's pretty fundamental, don't make it an option.
> 

I've removed GUNYAH_MESSAGE_QUEUES, GUNYAH_RESOURCE_MANAGER, and 
GUNYAH_VM_MANAGER.

These config options remain:
- GUNYAH (Patch 5)
- GUNYAH_PLATFORM_HOOKS (Patch 17)
- SAMPLE_GUNYAH (Patch 16)

 From the RFC patches, I'm planning on keeping all the options 
introduced there since they are not fundamental to launching a VM.
- GUNYAH_VCPU (Patch 25)
- GUNYAH_IRQFD (Patch 27)
- GUNYAH_IOEVENTFD (Patch 28)

>> +    tristate "Gunyah Resource Manager"
>> +    depends on MAILBOX
>> +    select GUNYAH_MESSAGE_QUEUES
>> +    help
>> +      The resource manager (RM) is a privileged application VM 
>> supporting
>> +      the Gunyah Hypervisor. Enable this driver to support communicating
>> +      with Gunyah RM. This is typically required for a VM running under
>> +      Gunyah wanting to have Gunyah-awareness.
>> +
>> +      Say Y/M here if unsure.
>> +endif
>> diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
>> index 2ac4ee64b89d..e7cf59b9e64e 100644
>> --- a/drivers/virt/gunyah/Makefile
>> +++ b/drivers/virt/gunyah/Makefile
>> @@ -1 +1,4 @@
>>   obj-$(CONFIG_GUNYAH) += gunyah.o
>> +
>> +gunyah_rsc_mgr-y += rsc_mgr.o
>> +obj-$(CONFIG_GUNYAH_RESOURCE_MANAGER) += gunyah_rsc_mgr.o
>> diff --git a/drivers/virt/gunyah/rsc_mgr.c 
>> b/drivers/virt/gunyah/rsc_mgr.c
>> new file mode 100644
>> index 000000000000..6b281576f5af
>> --- /dev/null
>> +++ b/drivers/virt/gunyah/rsc_mgr.c
>> @@ -0,0 +1,584 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights 
>> reserved.
>> + */
>> +
>> +#include <linux/of.h>
>> +#include <linux/slab.h>
>> +#include <linux/mutex.h>
>> +#include <linux/sched.h>
>> +#include <linux/gunyah.h>
>> +#include <linux/module.h>
>> +#include <linux/of_irq.h>
>> +#include <linux/kthread.h>
>> +#include <linux/notifier.h>
>> +#include <linux/workqueue.h>
>> +#include <linux/completion.h>
>> +#include <linux/gunyah_rsc_mgr.h>
>> +#include <linux/platform_device.h>
>> +
>> +#include "rsc_mgr.h"
>> +
>> +/* Resource Manager Header */
>> +struct gh_rm_rpc_hdr {
> 
> This is a style thing, but I prefer *not* having struct
> definitions with related value definitions interleaved.
> My preference would be to define the values above the
> struct definitions.  A comment can indicate which field
> a given group of definitions is associated with.  And
> if it's ambiguous, the symbol names can further tie
> them together.
> 

Done.

>> +#define RM_RPC_HDR_VERSION_ONE        0x1
> 
> I don't think HEADER_VERSION_ONE is any more understandable
> than just "1" if that's its value.  Unless you're envisioning
> a more complex versioning scheme, using 1, 2, 3 (etc.) for
> the versions is cleaner than VERSION_ONE, VERSION_TWO,
> VERSION_THREE, etc.
>  >> +#define RM_RPC_API_VERSION_MASK        GENMASK(3, 0)
>> +
>> +#define RM_RPC_HDR_WORDS        0x2
> 
> Here's another case where it might just be simpler to open-code
> the numeric value in the code.  Even better, I believe this
> represents the number of words in an RPC header.  That is better
> expressed as:
>      (sizeof(struct gh_rm_rpc_hdr) / sizeof(u32))
> 
> At this point it seems there *is* only one version.  Even so,
> the point of this (currently anyway) is to define the Gunyah
> RPC API that *this driver* supports.  That doesn't change for
> any message header, so maybe you could just define something
> like this:
> 
> #define RM_RPC_API_VERSION  FIELD_PREP(RM_RPC_API_VERSION_MASK, 1)
> #define RM_RPC_HDR_WORDS    FIELD_PREP(RM_RPC_HEADER_WORDS_MASK,
>                         (sizeof(structgh_rm_rpc_hdr) /
>                          sizeof(u32))
> #define RM_RPC_API        (RM_RPC_API_VERSION | RM_RPC_HDR_WORDS)
> 
> Then you can use RM_RPC_API in gh_rm_send_request() to fill in
> the api field of the RPC message header.  You could also check
> it in gh_rm_msgq_rx_data() (something you don't currently do).
> This might look a little ugly, but it simplifies the code where
> it's used.
> 

I like this approach, it doesn't seem uglier to me.

>> +#define RM_RPC_HEADER_WORDS_MASK    GENMASK(7, 4)
>> +    u8 api;
>> +
>> +#define RM_RPC_TYPE_CONT        0x0
>> +#define RM_RPC_TYPE_REQ        0x1
> 
> s/REQ/REQUEST/    (maybe)
> 
> Also there is a missing tab between the name and its value.
> 
>> +#define RM_RPC_TYPE_RPLY        0x2
> 
> s/RPLY/REPLY/
> 
>> +#define RM_RPC_TYPE_NOTIF        0x3
>> +#define RM_RPC_TYPE_MASK        GENMASK(1, 0)
>> +
>> +#define GH_RM_MAX_NUM_FRAGMENTS        62
>> +#define RM_RPC_FRAGMENTS_MASK       GENMASK(7, 2)
>> +    u8 type;
>> +    __le16 seq;
>> +    __le32 msg_id;
>> +} __packed;
>> +
>> +/* Standard reply header */
>> +struct gh_rm_rpc_reply_hdr {
>> +    struct gh_rm_rpc_hdr rpc_hdr;
>> +    u32 err_code;
> 
> Why is endianness represented in the sequence numbe r and
> message id in the header, but not in the error code here?
> Is the error code set by local software or something?
> 

I had missed adding this in the explicit le32_to_cpu conversions, it's 
added now.

> The values that can land in err_code are defined in
> "rsc_mgr.h" defined at the end of this patch.  Some
> examples are GH_RM_ERROR_OK and GH_RM_ERROR_NOMEM.
> Please indicate that somehow, for example:
> 
>      u32 err_code;    /* GH_RM_ERROR_**/
> 

Done.

> These values are (almost) always positive.  But I see
> two problems:
> - If non-zero, this value is returned by gh_rm_call(), and
>    that function is expected to return a *negative* value
>    on error.
> - RM_ERROR_UNIMPLEMENTED is defined as 0xffffffff; that
>    value, when interpreted as a signed int, is -1, which
>    if interpreted as an errno is EPERM.  That is at best
>    a misleading result if returned by gh_rm_call().
> 

Done. I've added retry logic for GH_ERROR_RETRY (so far never returned 
by resource manager, but it's in the spec).

>> +} __packed;
>> +
>> +#define GH_RM_MAX_MSG_SIZE    (GH_MSGQ_MAX_MSG_SIZE - sizeof(struct 
>> gh_rm_rpc_hdr))
>> +
>> +/**
>> + * struct gh_rm_connection - Represents a complete message from 
>> resource manager
>> + * @payload: Combined payload of all the fragments (msg headers 
>> stripped off).
>> + * @size: Size of the payload.
> 
> The size is the number of bytes of payload received *so far* (in
> case there are fragments).  It is not the size of the payload
> until it has been completely received.
> 

I've updated the comment to mention this.

>> + * @ret: Linux return code, set in case there was an error processing 
>> connection
>> + * @msg_id: Message ID from the header.
>> + * @type: RM_RPC_TYPE_RPLY or RM_RPC_TYPE_NOTIF.
>> + * @num_fragments: total number of fragments expected to be received.
>> + * @fragments_received: fragments received so far.
>> + * @rm_error: For request/reply sequences with standard replies.
>> + * @seq: Sequence ID for the main message.
>> + * @seq_done: Signals caller that the RM reply has been received
>> + */
>> +struct gh_rm_connection {
>> +    void *payload;
>> +    size_t size;
>> +    int ret;
>> +    u32 msg_id;
> 
> The msg_id field is actually opaque from this driver's perspective.
> The only thing that matters is if a response message ID *matches*
> a request message ID.  It could be maintained in __le32 byte order
> (as received).
> 

Done.

>> +    u8 type;
>> +
>> +    u8 num_fragments;
>> +    u8 fragments_received;
>> +
> 
> The next three fields are (as the comment says) only used for
> request/reply sequences.  You could put them in a structure,
> then have that structure share space in a union with a work
> structure used for notification messages.  That could replace
> struct gh_rm_notif_complete (which would become unnecessary).
> 

Done.

>> +    /* only for req/reply sequence */
>> +    u32 rm_error;
>> +    u16 seq;
>> +    struct completion seq_done;
>> +};
>> +
>> +struct gh_rm_notif_complete {
>> +    struct gh_rm_connection *conn;
>> +    struct work_struct work;
>> +};
>> +
>> +struct gh_rm_rpc {
> 
> I actually think this structure should just be called "gh_rm".
> Yes, it's the RPC interface for the resource manager, but this
> interface (which happens to use RPC) abstractly represents the
> resource manager *itself*.
> 

Done.

>> +    struct device *dev;
>> +    struct gunyah_resource tx_ghrsc, rx_ghrsc;
>> +    struct gh_msgq msgq;
>> +    struct mbox_client msgq_client;
>> +    struct gh_rm_connection *active_rx_connection;
>> +    int last_tx_ret;
>> +
>> +    struct idr call_idr;
>> +    struct mutex call_idr_lock;
>> +
>> +    struct mutex send_lock;
>> +
>> +    struct work_struct recv_work;
>> +};
>> +
>> +static struct gh_rm_connection *gh_rm_alloc_connection(u32 msg_id, u8 
>> type)
>> +{
>> +    struct gh_rm_connection *connection;
>> +
>> +    connection = kzalloc(sizeof(*connection), GFP_KERNEL);
>> +    if (!connection)
>> +        return NULL;
>> +
>> +    connection->type = type;
>> +    connection->msg_id = msg_id;
>> +
>> +    return connection;
>> +}
>> +
>> +static int gh_rm_init_connection_payload(struct gh_rm_connection 
>> *connection, void *msg,
>> +                    size_t hdr_size, size_t msg_size)
>> +{
>> +    struct gh_rm_rpc_hdr *hdr = msg;
>> +    size_t max_buf_size, payload_size;
>> +
>> +    if (hdr_size > msg_size)
>> +        return -EINVAL;
>> +
>> +    payload_size = msg_size - hdr_size;
> 
> The maximum payload size is 14616 bytes.  The msg_size comes
> from the resource manager--which I guess is trustworthy.  But
> you're already checking for a short message above, so you
> might as well check for a message that's too big as well.
> (Or just decide not to check either...)
> 

Done.

>> +    connection->num_fragments = FIELD_GET(RM_RPC_FRAGMENTS_MASK, 
>> hdr->type);
> 
> Here too, num_fragments had better not be more than
> GH_RM_MAX_NUM_FRAGMENTS (= 62).
> 
>> +    connection->fragments_received = 0;
>> +
>> +    /* There's not going to be any payload, no need to allocate 
>> buffer. */
>> +    if (!payload_size && !connection->num_fragments)
>> +        return 0;
>> +
>> +    /*
>> +     * maximum payload size is GH_MSGQ_MAX_MSG_SIZE- hdr_size
>> +     * and can received (hdr->fragments + 1) of those
>> +     */
>> +    max_buf_size = (GH_MSGQ_MAX_MSG_SIZE - hdr_size) * 
>> (connection->num_fragments + 1);
>> +
>> +    connection->payload = kzalloc(max_buf_size, GFP_KERNEL);
>> +    if (!connection->payload)
>> +        return -ENOMEM;
>> +
>> +    memcpy(connection->payload, msg + hdr_size, payload_size);
>> +    connection->size = payload_size;
>> +    return 0;
>> +}
>> +
>> +static void gh_rm_notif_work(struct work_struct *work)
>> +{
>> +    struct gh_rm_notif_complete *notif = container_of(work, struct 
>> gh_rm_notif_complete, work);
>> +    struct gh_rm_connection *connection = notif->conn;
>> +
>> +    /* No users of notifications, yet. */
>> +
>> +    kfree(connection->payload);
>> +    kfree(connection);
>> +    kfree(notif);
>> +}
>> +
>> +static struct gh_rm_connection *gh_rm_process_notif(struct gh_rm_rpc 
>> *rsc_mgr,
> 
> Here you use "rsc_mgr" as the symbol having this type, while
> elsewhere you use "rm".  Pick one, and use it consistenly (I
> suggest using "rm" to represent a "struct gh_rm").
> 

Done

>> +                            void *msg, size_t msg_size)
>> +{
>> +    struct gh_rm_rpc_hdr *hdr = msg;
>> +    struct gh_rm_connection *connection;
>> +
>> +    connection = gh_rm_alloc_connection(le32_to_cpu(hdr->msg_id),
> 
> We already know the header type is RM_RPC_TYPE_NOTIF.  Better
> to state that explicitly here rather than decoding what's in
> the header (again).
> 

Done.

>> +                        FIELD_GET(RM_RPC_TYPE_MASK, hdr->type));
>> +    if (!connection) {
>> +        dev_err(rsc_mgr->dev, "Failed to alloc connection for 
>> notification, dropping.\n");
>> +        return NULL;
>> +    }
>> +
>> +    if (gh_rm_init_connection_payload(connection, msg, sizeof(*hdr), 
>> msg_size)) {
> 
> This could conceivably return -EINVAL as well (which is not an
> allocation failure, despite what the message says).  The same
> thing is done in gh_rm_process_rply().  (If the resource manager
> is as trusted as it should be, and the hardware is not broken,
> -EINVAL should never get returned...)
> 

Updated the message to allow for -EINVAL.

>> +        dev_err(rsc_mgr->dev, "Failed to alloc connection buffer for 
>> notification, dropping.\n");
>> +        kfree(connection);
>> +        return NULL;
>> +    }
>> +
>> +    return connection;
>> +}
>> +
>> +static struct gh_rm_connection *gh_rm_process_rply(struct gh_rm_rpc 
>> *rsc_mgr,
>> +                           void *msg, size_t msg_size)
>> +{
>> +    struct gh_rm_rpc_reply_hdr *reply_hdr = msg;
>> +    struct gh_rm_rpc_hdr *hdr = msg;
> 
> Please use:
> 
>      struct gh_rm_rpc_hdr *hdr = &msg->rpc_hdr;
> 

Done.

>> +    struct gh_rm_connection *connection;
>> +    u16 seq_id = le16_to_cpu(hdr->seq);
>> +
>> +    if (mutex_lock_interruptible(&rsc_mgr->call_idr_lock))
>> +        return ERR_PTR(-ERESTARTSYS);
> 
> THIS IS A BUG.
> 
> If this call gets interrupted, we'll return the ERESTARTSYS pointer.
> That's non-null.
> 
> But the return value from gh_rm_process_rply() is blindly assigned
> to the rsc_mgr->active_rx_connection pointer in gh_rm_msgq_rx_data()
> if the RPC message type is RM_RPC_TYPE_RPLY.
> 
> Thereafter, if that pointer is non-null, it's assumed to refer
> to a valid memory location.
> 
> I'm not sure what the right handling is.  You could save the
> return value and check it with IS_ERR_OR_NULL().  Perhaps you
> could return NULL here too, but it's actually not clear to me
> you can simply ignore this situation and have the result be
> correct.
> 

I don't need interruptible lock here anyway as this function is now only 
called from threaded irq context.

>> +
>> +    connection = idr_find(&rsc_mgr->call_idr, seq_id);
>> +    mutex_unlock(&rsc_mgr->call_idr_lock);
>> +
>> +    if (!connection) {
>> +        dev_err(rsc_mgr->dev, "Failed to find connection for sequence 
>> %u\n", seq_id);
>> +        return NULL;
>> +    }
>> +    if (connection->msg_id != le32_to_cpu(hdr->msg_id)) {
>> +        dev_err(rsc_mgr->dev, "Replyfor sequence %u expected msg_id: 
>> %x but got %x\n",
>> +            seq_id, connection->msg_id, le32_to_cpu(hdr->msg_id));
>> +        /*
>> +         * Don't complete connection and error the client, maybe
>> +         * resource manager will send us the expected reply sequence 
>> soon.
>> +         */
>> +        return NULL;
>> +    }
>> +
>> +    if (gh_rm_init_connection_payload(connection, msg, 
>> sizeof(*reply_hdr), msg_size)) {
>> +        dev_err(rsc_mgr->dev, "Failed to alloc connection buffer for 
>> sequence %d\n",
>> +            seq_id);
>> +        /* Send connection complete and error the client. */
>> +        connection->ret = -ENOMEM;
>> +        complete(&connection->seq_done);
>> +        return NULL;
>> +    }
>> +
>> +    connection->rm_error = reply_hdr->err_code;
>> +    return connection;
> 
> Since you're already passing in the resource manager as an argument,
> you could take care of assigning its ->connection pointer here as well.
> Doing it this way *might* clean up the caller a bit (but sometimes
> you have to try it to see).
> 

In the current implementation, all of the handling 
"active_rx_connection" is done just in gh_rm_msgq_rx_data, which I think 
makes it easier to track how it's being used. If it's spread it out to 
gh_rm_process_*, I think it gets harder to follow if someone is new to 
the code.

>> +}
>> +
>> +static void gh_rm_process_cont(struct gh_rm_rpc *rsc_mgr, struct 
>> gh_rm_connection *connection,
>> +                void *msg, size_t msg_size)
>> +{
>> +    struct gh_rm_rpc_hdr *hdr = msg;
>> +    size_t payload_size = msg_size - sizeof(*hdr);
> 
> Maybe:
>      void *payload = hdr + 1;
> 
> Here too, the message size is coming from the resource manager.
> But it seems prudent to ensure msg_size is >= sizeof(*hdr)
> and <= GH_MSGQ_MAXMSG_SIZE.
> 

The max msg_size comes from hypervisor, but I will add a check that all 
the messages we receive are <= GH_MSGQ_MAX_MSG_SIZE.

>> +
>> +    /*
>> +     * hdr->fragments and hdr->msg_id preserves thevalue from first 
>> reply
>> +     * or notif message. To detect mishandling, check it's still intact.
>> +     */
>> +    if (connection->msg_id != le32_to_cpu(hdr->msg_id))
>> +        dev_err(rsc_mgr->dev, "Appending mismatched continuation with 
>> id %d to connection with id %d\n",
>> +            le32_to_cpu(hdr->msg_id), connection->msg_id);
>> +    if (connection->num_fragments != FIELD_GET(RM_RPC_FRAGMENTS_MASK, 
>> hdr->type))
>> +        dev_err(rsc_mgr->dev, "Number of fragments mismatch for seq: 
>> %d\n",
>> +            le16_to_cpu(hdr->seq));
> 
> The sequencer ID is irrelevant on a notification "connection".
> Maybe you should report the message type too?
> 
> You copy the contents into the receive buffer anyway?
> 
> I think you should drop the remainder of the "connection"
> if you see *any* corruption like this.  (I would argue
> this is a bug as well, though maybe it "never happens.")
> 

This is currently a case of "never happens". I think dropping remainder 
of the connection when this corruption happens is fine approach, too. 
I'll do that.

>> +
>> +    memcpy(connection->payload + connection->size, msg + 
>> sizeof(*hdr), payload_size);
>> +    connection->size += payload_size;
>> +    connection->fragments_received++;
>> +}
>> +
>> +static bool gh_rm_complete_connection(struct gh_rm_rpc *rsc_mgr,
>> +                    struct gh_rm_connection *connection)
> 
> This is called in one place, and it is always passed the active RX
> connection pointer.  If true is returned, that pointer is nulled.
> You could drop the second argument and just do the assignment
> here instead.  (With the above-mentioned bug, this is also a
> place where the non-null ERESTARTSYS pointer gets dererferenced.)
> 

Same as above comment about tracking active_rx_connection.

>> +{
>> +    struct gh_rm_notif_complete *notif_work;
>> +
>> +    if (!connection)
>> +        return false;
>> +
>> +    if (connection->fragments_received != connection->num_fragments)
>> +        return false;
>> +
>> +    switch (connection->type) {
>> +    case RM_RPC_TYPE_RPLY:
>> +        complete(&connection->seq_done);
>> +        break;
>> +    case RM_RPC_TYPE_NOTIF:
>> +        notif_work = kzalloc(sizeof(*notif_work), GFP_KERNEL);
>> +        if (notif_work == NULL)
>> +            break;
> 
> Is there any signficant consequence possible from quietly
> ignoring a notification from the resource manager?  Should
> this situation be reported at least?
> 
> If you embedded the work structure in the connection structure
> as I mentioned earlier, you could avoid this ever being a
> problem.
> 

Done by embedding the work structure in connection structure.

>> +
>> +        notif_work->conn = connection;
>> +        INIT_WORK(&notif_work->work,gh_rm_notif_work);
>> +
>> +        schedule_work(&notif_work->work);
>> +        break;
>> +    default:
>> +        dev_err(rsc_mgr->dev, "Invalid message type (%d) received\n", 
>> connection->type);
>> +        break;
>> +    }
>> +
>> +    return true;
>> +}
>> +
>> +static void gh_rm_abort_connection(struct gh_rm_connection *connection)
> 
> Although both callers immediately overwrite the rm->active_rx_connection
> pointer after this call, you could pass the resource manager pointer
> and make it NULL after the abort, so the old pointer is *gone*.
> 
>> +{
>> +    switch (connection->type) {
>> +    case RM_RPC_TYPE_RPLY:
>> +        connection->ret = -EIO;
>> +        complete(&connection->seq_done);
>> +        break;
>> +    case RM_RPC_TYPE_NOTIF:
>> +        fallthrough;
> 
> The case statement isn't really valuable here.  You could
> just do:
> 
>      if (connection->type == RM_RPC_TYPE_RPLY) {
>          ... complete
>      } else {
>          ... free
>      }
> 
> (Fine as-is though.)
> 
>> +    default:
>> +        kfree(connection->payload);
>> +        kfree(connection);
>> +    }
>> +}
>> +
>> +static void gh_rm_msgq_rx_data(struct mbox_client *cl, void *mssg)
>> +{
>> +    struct gh_rm_rpc *rsc_mgr = container_of(cl, struct gh_rm_rpc, 
>> msgq_client);
>> +    struct gh_msgq_rx_data *rx_data = mssg;
>> +    void *msg = rx_data->data;
>> +    size_t msg_size = rx_data->length;
>> +    struct gh_rm_rpc_hdr *hdr;
>> +
>> +    if (msg_size <= sizeof(struct gh_rm_rpc_hdr)) {
>> +        dev_err(rsc_mgr->dev, "Incomplete message size: %ld is too 
>> small\n", msg_size);
>> +        return;
>> +    }
> 
> This is received data, so as long as you're verifying the message
> size you should also ensure it's within the maximum allowed.  You
> should also verify the header api byte is correct.
> 

Done.

>> +
>> +    hdr = msg;
>> +    switch (FIELD_GET(RM_RPC_TYPE_MASK, hdr->type)) {
>> +    case RM_RPC_TYPE_NOTIF:
> 
> Here and in the other cases below, I think it's cleaner if you
> move the check of the active_rx_connection poiner (whether it's
> NULL or not) into the called functions.  That way they're all
> checking based on their own requirements rather than having
> that logic be here.
> 
>> +        if (rsc_mgr->active_rx_connection) {
>> +            /* Not possible per protocol. Do something better than 
>> BUG_ON */
>> +            dev_err(rsc_mgr->dev, "Received start of new notification 
>> without finishing existing message series.\n");
>> +            gh_rm_abort_connection(rsc_mgr->active_rx_connection);
>> +        }
>> +        rsc_mgr->active_rx_connection = gh_rm_process_notif(rsc_mgr, 
>> msg, msg_size);
>> +        break;
>> +    case RM_RPC_TYPE_RPLY:
>> +        if (rsc_mgr->active_rx_connection) {
>> +            /* Not possible per protocol. Do something better than 
>> BUG_ON */
>> +            dev_err(rsc_mgr->dev, "Received start of new reply 
>> without finishing existing message series.\n");
>> +            gh_rm_abort_connection(rsc_mgr->active_rx_connection);
>> +        }
>> +        rsc_mgr->active_rx_connection = gh_rm_process_rply(rsc_mgr, 
>> msg, msg_size);
>> +        break;
>> +    case RM_RPC_TYPE_CONT:
>> +        if (!rsc_mgr->active_rx_connection) {
>> +            dev_err(rsc_mgr->dev, "Received a continuation message 
>> without receiving initial message\n");
>> +            break;
>> +        }
>> +        gh_rm_process_cont(rsc_mgr, rsc_mgr->active_rx_connection, 
>> msg, msg_size);
>> +        break;
>> +    default:
>> +        dev_err(rsc_mgr->dev, "Invalid message type (%lu) received\n",
>> +            FIELD_GET(RM_RPC_TYPE_MASK, hdr->type));
>> +        return;
>> +    }
>> +
>> +    if (gh_rm_complete_connection(rsc_mgr, 
>> rsc_mgr->active_rx_connection))
>> +        rsc_mgr->active_rx_connection = NULL;
>> +}
>> +
>> +static void gh_rm_msgq_tx_done(struct mbox_client *cl, void *mssg, 
>> int r)
>> +{
>> +    struct gh_rm_rpc *rsc_mgr = container_of(cl, struct gh_rm_rpc, 
>> msgq_client);
>> +
>> +    kfree(mssg);
>> +    rsc_mgr->last_tx_ret = r;
>> +}
>> +
> 
> It is allowable to pass a null req_buff pointer here.  The handling in
> that case is a little different, and I think it's important to both
> state that a null pointer is OK, and to explain what it means (or
> how its processing is different).
> 

Done.

>> +static int gh_rm_send_request(struct gh_rm_rpc *rsc_mgr, u32 message_id,
>> +                  const void *req_buff, size_t req_buff_size,
>> +                  struct gh_rm_connection *connection)
>> +{
>> +    size_t buff_size_remaining = req_buff_size;
>> +    const void *req_buff_curr = req_buff;
>> +    struct gh_rm_rpc_hdr *hdr;
>> +    u32 cont_fragments = 0;
>> +    size_t payload_size;
>> +    struct gh_msgq_tx_data *msg;
>> +    int i, ret;
>> +
>> +    if (req_buff_size)
>> +        cont_fragments = (req_buff_size - 1) / GH_RM_MAX_MSG_SIZE;
>> +
>> +    if (WARN(cont_fragments > GH_RM_MAX_NUM_FRAGMENTS,
>> +         "Limit exceeded for the number of fragments: %u\n", 
>> cont_fragments))
>> +        return -E2BIG;
> 
> You could just do:
> 
>    if (WARN(req_buff_size > GH_RM_MAX_MSG_SIZE * GHRM_MAX_NUM_FRAGMENTS,
>        ...
> 
> And then your loop below could just do:
> 
>      u8 type = RM_RPC_TYPE_REQ;
> 
>      while (req_buff_size) {
>          payload_size = max(buff_size_remaining,
>                     GH_RM_MAX_MSG_SIZE);
> 
>          req_buff_size -= payload_size;
>              ...
>          msg->push = !req_buff_size;
>              ...
>          type = RM_RPC_TYPE_CONT;
>      }
> 

Done.

>> +
>> +    ret = mutex_lock_interruptible(&rsc_mgr->send_lock);
>> +    if (ret)
>> +        return ret;
>> +
>> +    /* Consider also the 'request' packet for the loop count */
>> +    for (i = 0; i <= cont_fragments; i++) {
>> +        if (buff_size_remaining > GH_RM_MAX_MSG_SIZE) {
>> +            payload_size = GH_RM_MAX_MSG_SIZE;
>> +            buff_size_remaining -= payload_size;
>> +        } else {
>> +            payload_size = buff_size_remaining;
>> +        }
>> +
>> +        msg = kzalloc(sizeof(*msg)+ GH_MSGQ_MAX_MSG_SIZE, GFP_KERNEL);
> 
> Use:
>      msg = kzalloc(sizeof(*msg) + payload_size, GFP_KERNEL);
> 
> But even better:
>      msg = kzalloc(struct_size(msg, data, payload_size),GFP_KERNEL);
> 
> OR...  since these buffers are always 256 bytes apiece, you could
> create a slab cache so they're allocated efficiently.
> 

Will switch to kmem_cache.

>> +        if (!msg) {
>> +            ret = -ENOMEM;
>> +            gotoout;
>> +        }
>> +
>> +        /* Fill header */
>> +        hdr = (struct gh_rm_rpc_hdr *)msg->data;
>> +        hdr->api = FIELD_PREP(RM_RPC_API_VERSION_MASK, 
>> RM_RPC_HDR_VERSION_ONE) |
>> +                FIELD_PREP(RM_RPC_HEADER_WORDS_MASK, RM_RPC_HDR_WORDS);
> 
> I suggested defining this api value at the top, since it's
> constant for a given build.
> 
Ack.

>> +        hdr->type = FIELD_PREP(RM_RPC_TYPE_MASK,
>> +                    i == 0 ? RM_RPC_TYPE_REQ : RM_RPC_TYPE_CONT) |
>> +                FIELD_PREP(RM_RPC_FRAGMENTS_MASK, cont_fragments);
> 
> I think FIELD_PREP() (and u32_encode_bits()) can look a
> little cumbersome.  I think this would be more readable:
> 
>      u8 type = i ? RM_RPC_TYPE_CONT : RM_RPC_TYPE_REQ;
> 
>      hdr->type = FIELD_PREP(RM_RPC_TYPE_MASK, type);
>      hdr->type |= FIELD_PREP(RM_RPC_FRAGMENTS_MASK, cont_fragments);
> 
> 
>> +        hdr->seq = cpu_to_le16(connection->seq);
>> +        hdr->msg_id = cpu_to_le32(message_id);
>> +
>> +        /* Copy payload */
> 
> Maybe:
>          void *payload = hdr + 1;
>          ...
>          memcpy(payload, req_buff_curr, payload_size);
> 
>> +        memcpy(msg->data + sizeof(*hdr), req_buff_curr, payload_size);
>> +        req_buff_curr += payload_size;
>> +
>> +        /* Force the last fragment to immediately alert the receiver */
>> +        msg->push = i == cont_fragments;
>> +        msg->length = sizeof(*hdr)+ payload_size;
>> +
>> +        ret = mbox_send_message(gh_msgq_chan(&rsc_mgr->msgq), msg);
>> +        if (ret < 0) {
>> +            kfree(msg);
>> +            break;
>> +        }
>> +
>> +        if (rsc_mgr->last_tx_ret) {
>> +            ret = rsc_mgr->last_tx_ret;
>> +            break;
>> +        }
>> +    }
>> +
>> +out:
>> +    mutex_unlock(&rsc_mgr->send_lock);
>> +    return ret < 0 ? ret : 0;
>> +}
>> +
>> +/**
>> + * gh_rm_call: Achieve request-response type communication with RPC
> 
>      * @rsc_mgr:  ...
> 
>> + * @message_id: The RM RPC message-id
>> + * @req_buff: Request buffer that contains the payload
>> + * @req_buff_size: Total size of the payload
>> + * @resp_buf: Pointer to a response buffer
>> + * @resp_buff_size: Size of the response buffer
>> + *
>> + * Make a request to the RM-VM and wait for reply back. For a successful
>> + * response, the function returns the payload. The size of the 
>> payload is set in
>> + * resp_buff_size. The resp_buf should be freed by the caller.
>> + *
>> + * Context: Process context. Will sleep waiting for reply.
>> + * Return: >0 is standard reply error from RM. <0 on internal error.
>> + */
>> +int gh_rm_call(struct gh_rm_rpc *rsc_mgr, u32 message_id, void 
>> *req_buff, size_t req_buff_size,
>> +        void **resp_buf, size_t *resp_buff_size)
>> +{
>> +    struct gh_rm_connection *connection;
>> +    int ret;
>> +
>> +    /* messaged_id 0 is reserved */
>> +    if (!message_id)
>> +        return -EINVAL;
>> +
> 
> Maybe check for null rsc_mgr first.
> 

Every caller is guaranteed to have valid rm pointer.

>> +    if (!rsc_mgr)
>> +        return -EPROBE_DEFER;
>> +
>> +    connection = gh_rm_alloc_connection(message_id, RM_RPC_TYPE_RPLY);
>> +    if (!connection)
>> +        return -ENOMEM;
>> +
>> +    init_completion(&connection->seq_done);
>> +
>> +    /* Allocate a new seq number for this connection */
>> +    if (mutex_lock_interruptible(&rsc_mgr->call_idr_lock)) {
> 
> Maybe use the goto ... pattern here.
> 
>> +        kfree(connection);
>> +        return -ERESTARTSYS;
>> +    }
>> +    connection->seq = idr_alloc_cyclic(&rsc_mgr->call_idr, 
>> connection, 0, U16_MAX, GFP_KERNEL);
> 
> Note that idr_alloc_cyclic() *can* return an error.
> 

Done.

>> +    mutex_unlock(&rsc_mgr->call_idr_lock);
>> +
>> +    /* Send the request to the Resource Manager */
>> +    ret = gh_rm_send_request(rsc_mgr, message_id, req_buff, 
>> req_buff_size, connection);
>> +    if (ret < 0)
>> +        goto out;
>> +
>> +    /* Wait for response */
>> +    ret = wait_for_completion_interruptible(&connection->seq_done);
>> +    if (ret)
>> +        goto out;
>> +
>> +    if (connection->ret) {
>> +        ret = connection->ret;
> 
> I note that this is a negative errno.  (You do explain
> that non-zero return means error above.)
> 
>> +        kfree(connection->payload);
>> +        goto out;
>> +    }
>> +
>> +    if (connection->rm_error) {
>> +        ret = connection->rm_error;
> 
> While this is positive resource manager error (with one exception
> I mentioned earlier).
> 
>> +        kfree(connection->payload);
>> +        goto out;
>> +    }
>> +
>> +    *resp_buf = connection->payload;
>> +    *resp_buff_size = connection->size;
>> +
>> +out:
>> +    mutex_lock(&rsc_mgr->call_idr_lock);
> 
> Why is the mutex_lock() here not interruptible?  Or rather, if
> you can do a non-interruptible wait here, why not above?
>

I've removed the interruptible call_idr_lock because all the sections 
which use are quick.

>> +    idr_remove(&rsc_mgr->call_idr, connection->seq);
>> +    mutex_unlock(&rsc_mgr->call_idr_lock);
>> +
>> +    kfree(connection);
>> +    return ret;
>> +}
>> +
>> +static int gh_msgq_platform_probe_direction(struct platform_device 
>> *pdev,
>> +                    u8 gh_type, int idx, struct gunyah_resource *ghrsc)
> 
> I think I might call this gh_msgq_platform_probe_msgq() and pass a
> Boolean indicating whether it's being called for the RX (versus TX)
> message queue.  Then deduce the gh_type and the index from that
> argument.
> 

Done.

>                      -Alex
> 
>> +{
>> +    int ret;
>> +    struct device_node *node = pdev->dev.of_node;
>> +
>> +    ghrsc->type = gh_type;
>> +
>> +    ghrsc->irq = platform_get_irq(pdev, idx);
>> +    if (ghrsc->irq < 0) {
>> +        dev_err(&pdev->dev, "Failed to get irq%d: %d\n", idx, 
>> ghrsc->irq);
>> +        return ghrsc->irq;
>> +    }
>> +
>> +    ret = of_property_read_u64_index(node, "reg", idx,&ghrsc->capid);
>> +    if (ret) {
>> +        dev_err(&pdev->dev, "Failed to get capid%d: %d\n", idx, ret);
>> +        return ret;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static int gh_rm_drv_probe(struct platform_device *pdev)
>> +{
>> +    struct gh_rm_rpc *rsc_mgr;
>> +    int ret;
>> +
>> +    rsc_mgr = devm_kzalloc(&pdev->dev, sizeof(*rsc_mgr), GFP_KERNEL);
>> +    if (!rsc_mgr)
>> +        return -ENOMEM;
>> +
>> +    platform_set_drvdata(pdev, rsc_mgr);
>> +    rsc_mgr->dev = &pdev->dev;
>> +
>> +    mutex_init(&rsc_mgr->call_idr_lock);
>> +    idr_init(&rsc_mgr->call_idr);
>> +    mutex_init(&rsc_mgr->send_lock);
>> +
>> +    ret = gh_msgq_platform_probe_direction(pdev, 
>> GUNYAH_RESOURCE_TYPE_MSGQ_TX, 0,
>> +                        &rsc_mgr->tx_ghrsc);
>> +    if (ret)
>> +        return ret;
>> +
>> +    ret = gh_msgq_platform_probe_direction(pdev, 
>> GUNYAH_RESOURCE_TYPE_MSGQ_RX, 1,
>> +                        &rsc_mgr->rx_ghrsc);
>> +    if (ret)
>> +        return ret;
>> +
>> +    rsc_mgr->msgq_client.dev = &pdev->dev;
>> +    rsc_mgr->msgq_client.tx_block = true;
>> +    rsc_mgr->msgq_client.rx_callback = gh_rm_msgq_rx_data;
>> +    rsc_mgr->msgq_client.tx_done = gh_rm_msgq_tx_done;
>> +
>> +    return gh_msgq_init(&pdev->dev, &rsc_mgr->msgq, 
>> &rsc_mgr->msgq_client,
>> +                &rsc_mgr->tx_ghrsc, &rsc_mgr->rx_ghrsc);
>> +}
>> +
>> +static int gh_rm_drv_remove(struct platform_device *pdev)
>> +{
>> +    struct gh_rm_rpc *rm = platform_get_drvdata(pdev);
>> +
>> +    mbox_free_channel(gh_msgq_chan(&rm->msgq));
>> +    gh_msgq_remove(&rm->msgq);
>> +
>> +    return 0;
>> +}
>> +
>> +static const struct of_device_id gh_rm_of_match[] = {
>> +    { .compatible = "gunyah-resource-manager" },
>> +    {}
>> +};
>> +MODULE_DEVICE_TABLE(of, gh_rm_of_match);
>> +
>> +static struct platform_driver gh_rm_driver = {
>> +    .probe = gh_rm_drv_probe,
>> +    .remove = gh_rm_drv_remove,
>> +    .driver = {
>> +        .name = "gh_rsc_mgr",
>> +        .of_match_table = gh_rm_of_match,
>> +    },
>> +};
>> +module_platform_driver(gh_rm_driver);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_DESCRIPTION("Gunyah Resource Manager Driver");
>> diff --git a/drivers/virt/gunyah/rsc_mgr.h 
>> b/drivers/virt/gunyah/rsc_mgr.h
>> new file mode 100644
>> index 000000000000..b5bb36a7a4cc
>> --- /dev/null
>> +++ b/drivers/virt/gunyah/rsc_mgr.h
>> @@ -0,0 +1,36 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights 
>> reserved.
>> + */
>> +#ifndef __GH_RSC_MGR_PRIV_H
>> +#define __GH_RSC_MGR_PRIV_H
>> +
>> +#include <linux/gunyah.h>
>> +#include <linux/types.h>
>> +
>> +/* RM Error codes */
>> +#define GH_RM_ERROR_OK            0x0
>> +#define GH_RM_ERROR_UNIMPLEMENTED    0xFFFFFFFF
>> +#define GH_RM_ERROR_NOMEM        0x1
>> +#define GH_RM_ERROR_NORESOURCE        0x2
>> +#define GH_RM_ERROR_DENIED        0x3
>> +#define GH_RM_ERROR_INVALID        0x4
>> +#define GH_RM_ERROR_BUSY        0x5
>> +#define GH_RM_ERROR_ARGUMENT_INVALID    0x6
>> +#define GH_RM_ERROR_HANDLE_INVALID    0x7
>> +#define GH_RM_ERROR_VALIDATE_FAILED    0x8
>> +#define GH_RM_ERROR_MAP_FAILED        0x9
>> +#define GH_RM_ERROR_MEM_INVALID        0xA
>> +#define GH_RM_ERROR_MEM_INUSE       0xB
>> +#define GH_RM_ERROR_MEM_RELEASED    0xC
>> +#define GH_RM_ERROR_VMID_INVALID    0xD
>> +#define GH_RM_ERROR_LOOKUP_FAILED    0xE
>> +#define GH_RM_ERROR_IRQ_INVALID        0xF
>> +#define GH_RM_ERROR_IRQ_INUSE       0x10
>> +#define GH_RM_ERROR_IRQ_RELEASED    0x11
>> +
>> +struct gh_rm_rpc;
>> +int gh_rm_call(struct gh_rm_rpc *rsc_mgr, u32 message_id, void 
>> *req_buff, size_t req_buff_size,
>> +        void **resp_buf, size_t *resp_buff_size);
>> +
>> +#endif
>> diff --git a/include/linux/gunyah_rsc_mgr.h 
>> b/include/linux/gunyah_rsc_mgr.h
>> new file mode 100644
>> index 000000000000..b4f55c19954b
>> --- /dev/null
>> +++ b/include/linux/gunyah_rsc_mgr.h
>> @@ -0,0 +1,18 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights 
>> reserved.
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
>> +
>> +/* Gunyah recognizes VMID0 as an alias to the current VM's ID */
>> +#define GH_VMID_SELF            0
>> +
>> +#endif
> 
