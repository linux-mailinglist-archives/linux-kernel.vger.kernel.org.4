Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB2472A64F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 00:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbjFIWfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 18:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbjFIWfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 18:35:51 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA0C35B8;
        Fri,  9 Jun 2023 15:35:49 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 359MDLQp019430;
        Fri, 9 Jun 2023 22:35:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=4ECFYGWgHxIfacttR0hwtCNIBUZDxJHuS/5evG0+o7I=;
 b=h7Z+j/Zxm1BfNe0J1/LwgCKGnFQauif7LhmuN+GMSt8qm74myd7FbJ27g5JimTbSZ395
 +kFYyUhJnaY8V0V3oT4CRJu2C9EEwDbdEF2k3bRaKRWGhoVoWUwHCnYXI0EyqWwRh+zT
 dLK6ZPIxHlA5SnBMZWrQlW/L1S0fEJYtT+K49UPilpmb8MlpoJY3TtjzJLtwx8EPiX3o
 Bay5HK9z2qcV0F+6RKQlsDAc3G7Ai9eP37P7PXRh5hDzx0iZZnrURnXULwvB1ddfcoDi
 ZR07q/2JT8LGV2cL2yYJlXY53/MG3iSNGAHeaLfmHS0b+fc550ghD9VgU/NLUmFcnV3i eA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r3xyx9sq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jun 2023 22:35:33 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 359MZWPB029738
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Jun 2023 22:35:32 GMT
Received: from [10.134.65.165] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 9 Jun 2023
 15:35:31 -0700
Message-ID: <d31ac48b-13d3-cb9c-7a59-220b31a89274@quicinc.com>
Date:   Fri, 9 Jun 2023 15:35:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v13 09/24] gunyah: rsc_mgr: Add RPC for sharing memory
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
References: <20230509204801.2824351-1-quic_eberman@quicinc.com>
 <20230509204801.2824351-10-quic_eberman@quicinc.com>
 <9747a71d-c6d0-b67b-a3b1-c84848268f46@linaro.org>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <9747a71d-c6d0-b67b-a3b1-c84848268f46@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Xmr9_AEb6KAl9_XsOFdiBftexFt5N-m5
X-Proofpoint-GUID: Xmr9_AEb6KAl9_XsOFdiBftexFt5N-m5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_16,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306090191
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/5/2023 12:48 PM, Alex Elder wrote:
> On 5/9/23 3:47 PM, Elliot Berman wrote: >> +
>> +    req_header->mem_handle = cpu_to_le32(mem_handle);
>> +    if (end_append)
>> +        req_header->flags |= GH_MEM_APPEND_REQ_FLAGS_END;
>> +
>> +    mem_section->n_entries = cpu_to_le16(n_mem_entries);
>> +    memcpy(mem_section->entries, mem_entries, sizeof(*mem_entries) * 
>> n_mem_entries);
>> +
>> +    ret = gh_rm_call(rm, GH_RM_RPC_MEM_APPEND, msg, msg_size, NULL, 
>> NULL);
>> +    kfree(msg);
>> +
>> +    return ret;
>> +}
>> +
>> +static int gh_rm_mem_append(struct gh_rm *rm, u32 mem_handle,
>> +            struct gh_rm_mem_entry *mem_entries, size_t n_mem_entries)
>> +{
>> +    bool end_append;
>> +    int ret = 0;
>> +    size_t n;
>> +
>> +    while (n_mem_entries) {
>> +        if (n_mem_entries > GH_RM_MAX_MEM_ENTRIES) {
>> +            end_append = false;
>> +            n = GH_RM_MAX_MEM_ENTRIES;
>> +        } else {
>> +            end_append = true;
>> +            n = n_mem_entries;
>> +        }
>> +
>> +        ret = _gh_rm_mem_append(rm, mem_handle, end_append, 
>> mem_entries, n);
>> +        if (ret)
>> +            break;
>> +
>> +        mem_entries += n;
>> +        n_mem_entries -= n;
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>> +static int gh_rm_mem_lend_common(struct gh_rm *rm, u32 message_id, 
>> struct gh_rm_mem_parcel *p)
>> +{
>> +    size_t msg_size = 0, initial_mem_entries = p->n_mem_entries, 
>> resp_size;
>> +    size_t acl_section_size, mem_section_size;
>> +    struct gh_rm_mem_share_req_acl_section *acl_section;
>> +    struct gh_rm_mem_share_req_mem_section *mem_section;
>> +    struct gh_rm_mem_share_req_header *req_header;
>> +    u32 *attr_section;
>> +    __le32 *resp;
>> +    void *msg;
>> +    int ret;
>> +
>> +    if (!p->acl_entries || !p->n_acl_entries || !p->mem_entries || 
>> !p->n_mem_entries ||
>> +        p->n_acl_entries > U8_MAX || p->mem_handle != 
>> GH_MEM_HANDLE_INVAL)
>> +        return -EINVAL;
>> +
>> +    if (initial_mem_entries > GH_RM_MAX_MEM_ENTRIES)
>> +        initial_mem_entries = GH_RM_MAX_MEM_ENTRIES;
> 
> Is it OK to truncate the number of entries silently?
> 

The initial share/lend accepts GH_RM_MAX_MEM_ENTRIES. I append the rest 
of the mem entries later.

>> +
>> +    acl_section_size = struct_size(acl_section, entries, 
>> p->n_acl_entries);
> 
> Is there a limit on the number of ACL entries (as there is for
> the number of mem entries).
> 

There is limit based at the transport level -- messages sent to resource 
manager can only be so long. Max # ACL entries limit is dynamic based on 
the size of the rest of the message such as how many mem entries there 
are. We could try to compute the limit and even lower max number of 
mem_entries, but max # of ACL entries in practice will single digits so 
it seemed premature optimization to be "smarter" about the limit and let 
the RPC core do the checking/complaining.

>> +    mem_section_size = struct_size(mem_section, entries, 
>> initial_mem_entries);
>> +    /* The format of the message goes:
>> +     * request header
>> +     * ACL entries (which VMs get what kind of access to this memory 
>> parcel)
>> +     * Memory entries (list of memory regions to share)
>> +     * Memory attributes (currently unused, we'll hard-code the size 
>> to 0)
>> +     */
>> +    msg_size += sizeof(struct gh_rm_mem_share_req_header);
>> +    msg_size += acl_section_size;
>> +    msg_size += mem_section_size;
>> +    msg_size += sizeof(u32); /* for memory attributes, currently 
>> unused */
>> +
>> +    msg = kzalloc(msg_size, GFP_KERNEL);
>> +    if (!msg)
>> +        return -ENOMEM;
>> +
>> +    req_header = msg;
>> +    acl_section = (void *)req_header + sizeof(*req_header);
>> +    mem_section = (void *)acl_section + acl_section_size;
>> +    attr_section = (void *)mem_section + mem_section_size;
>> +
>> +    req_header->mem_type = p->mem_type;
>> +    if (initial_mem_entries != p->n_mem_entries)
>> +        req_header->flags |= GH_MEM_SHARE_REQ_FLAGS_APPEND;
>> +    req_header->label = cpu_to_le32(p->label);
>> +
>> +    acl_section->n_entries = cpu_to_le32(p->n_acl_entries);
>> +    memcpy(acl_section->entries, p->acl_entries,
>> +        flex_array_size(acl_section, entries, p->n_acl_entries));
>> +
>> +    mem_section->n_entries = cpu_to_le16(initial_mem_entries);
>> +    memcpy(mem_section->entries, p->mem_entries,
>> +        flex_array_size(mem_section, entries, initial_mem_entries));
>> +
>> +    /* Set n_entries for memory attribute section to 0 */
>> +    *attr_section = 0;
>> +
>> +    ret = gh_rm_call(rm, message_id, msg, msg_size, (void **)&resp, 
>> &resp_size);
>> +    kfree(msg);
>> +
>> +    if (ret)
>> +        return ret;
>> +
>> +    p->mem_handle = le32_to_cpu(*resp);
>> +    kfree(resp);
>> +
>> +    if (initial_mem_entries != p->n_mem_entries) {
>> +        ret = gh_rm_mem_append(rm, p->mem_handle,
>> +                    &p->mem_entries[initial_mem_entries],
>> +                    p->n_mem_entries - initial_mem_entries);
> 
> Will there always be at most one gh_rm_mem_append() call?
> 

Yes, gh_rm_mem_append makes multiple RPC calls as necessary for all the 
remaining entries.

>> +        if (ret) {
>> +            gh_rm_mem_reclaim(rm, p);
>> +            p->mem_handle = GH_MEM_HANDLE_INVAL;
>> +        }
>> +    }
>> +
>> +    return ret;
>> +}
> 
> . . .
> 
