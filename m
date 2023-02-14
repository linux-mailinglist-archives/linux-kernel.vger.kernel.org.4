Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956276955EF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 02:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjBNB1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 20:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjBNB1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 20:27:11 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8135713525;
        Mon, 13 Feb 2023 17:27:10 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31DNYTxH005441;
        Tue, 14 Feb 2023 01:27:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=dx8j9BRxh1R2Pbwqe1IpU3+hI2xSWoY+YDPpwHts8mY=;
 b=h9uoOXCKdt890I13lp6204fXxCcZwx0+Z7LjhsILbOCEx+iSyCTPhQLnlTQkkMX/KyeM
 28xxZIvc5G4Knq5Bm1OB/fFqJa9PttQXdBiCD3vY7/+KzMYMVhW0iuQNWmcQoWQT4m3G
 XAsnSYjzPPFT4g57h7r0pJ0QZGRUuVwP0EVRA21F+wsrqrya7ohk8c8HfDiXYwh4lqth
 tfLroj2cZNNYX6OkHu21Nk1ix798Up8ubCQj1P08zaTeYY2Y6z4w48e2Pi8npE9sCOnv
 wwjuCGv/ZVXHZNjAgW27vfcRSN4c/9Xob1mcA6iq8wijCG/c6EZZ1OVQ2Sf0XUXYxDgX NQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nqtsurp3p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 01:27:08 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31E1R7eo009720
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 01:27:07 GMT
Received: from [10.216.32.233] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 13 Feb
 2023 17:27:04 -0800
Message-ID: <57a5133d-4eeb-7c0b-e4ad-fb10d60157e6@quicinc.com>
Date:   Tue, 14 Feb 2023 06:57:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RFC] usb: gadget: ncm: Add support to configure wMaSegmentSize
Content-Language: en-US
To:     =?UTF-8?Q?Maciej_=c5=bbenczykowski?= <maze@google.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_jackp@quicinc.com>
References: <20230212175659.4480-1-quic_kriskura@quicinc.com>
 <CANP3RGerSsUPhzdExrok_sc2jst2firjsEkaLepHDgt_sFmO4w@mail.gmail.com>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <CANP3RGerSsUPhzdExrok_sc2jst2firjsEkaLepHDgt_sFmO4w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4tCxl75Z6mZST_M0rjFgYFo9BZEtzEMU
X-Proofpoint-ORIG-GUID: 4tCxl75Z6mZST_M0rjFgYFo9BZEtzEMU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_13,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 adultscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302140008
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/14/2023 3:17 AM, Maciej Żenczykowski wrote:
> This isn't a review per say - just some loose comments.
> 
> On Sun, Feb 12, 2023 at 9:57 AM Krishna Kurapati
> <quic_kriskura@quicinc.com> wrote:
>> Currently the NCM driver restricts wMasxSegmentSize that indicates
> 
> there's a number of spelling mistakes, here, and in the commit title
> 
>> the datagram size coming from network layer to 1514. However the
>> spec doesn't have any limitation.
>>
>> Add support to configure this value before configfs symlink is
>> created. Also since the NTB Out/In buffer sizes are fixed at 16384
>> bytes, limit the segment size to an upper cap of 8192 bytes so that
>> at least 2 packets can be aggregated.
> 
> I've experimented with increasing mtu to boost performance before
> (have some half-baked patches/scripts somewhere).
> And while it did improve point-to-point performance, it wasn't
> actually useful for any real world use cases,
> as internet mtu is simply never above 1500.
> 
> Note that you cannot simply receive, aggregate (lro/gro) and forward
> aggregated packets without splitting them back up.
One more query on this:

Would this problem come up if the MTU and segment size are consistent as 
well ? i.e., if the datagrams present in NTB are  of size <= MTU so that 
they can be given back safely to network stack without any further 
aggregation/splitup before wrap/unwrap call at usb layer ?

Regards,
Krishna,

> 
> A change like this to be useful would require negotiating some sort of
> gso capabilities between the two devices
> (and thus extending the NCM standard).  I've been meaning to do
> this... but time...
> 
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>> ---
>>   drivers/usb/gadget/function/f_ncm.c | 55 +++++++++++++++++++++++++++++
>>   drivers/usb/gadget/function/u_ncm.h |  1 +
>>   2 files changed, 56 insertions(+)
>>
>> diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
>> index 424bb3b666db..1969e276017f 100644
>> --- a/drivers/usb/gadget/function/f_ncm.c
>> +++ b/drivers/usb/gadget/function/f_ncm.c
>> @@ -118,6 +118,12 @@ static inline unsigned ncm_bitrate(struct usb_gadget *g)
>>   /* Delay for the transmit to wait before sending an unfilled NTB frame. */
>>   #define TX_TIMEOUT_NSECS       300000
>>
>> +/*
>> + * Currently the max NTB Buffer size is set to 16384. For atleast 2 packets
>> + * to be aggregated, the size of datagram must at max be 8192.
>> + */
>> +#define MAX_DATAGRAM_SIZE      8192
> 
>  From what I recall, there's a fair bit of overhead, and 8192 x2
> doesn't actually fit in 16384...
> That said... is it reasonable to require 2 to fit?  why? what's wrong
> with 15000?
> 
>> +
>>   #define FORMATS_SUPPORTED      (USB_CDC_NCM_NTB16_SUPPORTED |  \
>>                                   USB_CDC_NCM_NTB32_SUPPORTED)
>>
>> @@ -1440,6 +1446,7 @@ static int ncm_bind(struct usb_configuration *c, struct usb_function *f)
>>           */
>>          if (!ncm_opts->bound) {
>>                  mutex_lock(&ncm_opts->lock);
>> +               ncm_opts->net->mtu = (ncm_opts->max_segment_size - 14);
> 
> this should use a constant, ETH_HLEN probably
> 
>>                  gether_set_gadget(ncm_opts->net, cdev->gadget);
>>                  status = gether_register_netdev(ncm_opts->net);
>>                  mutex_unlock(&ncm_opts->lock);
>> @@ -1484,6 +1491,8 @@ static int ncm_bind(struct usb_configuration *c, struct usb_function *f)
>>
>>          status = -ENODEV;
>>
>> +       ecm_desc.wMaxSegmentSize = ncm_opts->max_segment_size;
>> +
> 
> Curious... wasn't this set previously?
> 
>>          /* allocate instance-specific endpoints */
>>          ep = usb_ep_autoconfig(cdev->gadget, &fs_ncm_in_desc);
>>          if (!ep)
>> @@ -1586,11 +1595,56 @@ USB_ETHERNET_CONFIGFS_ITEM_ATTR_QMULT(ncm);
>>   /* f_ncm_opts_ifname */
>>   USB_ETHERNET_CONFIGFS_ITEM_ATTR_IFNAME(ncm);
>>
>> +static ssize_t ncm_opts_max_segment_size_show(struct config_item *item,
>> +                                               char *page)
>> +{
>> +       struct f_ncm_opts *opts = to_f_ncm_opts(item);
>> +       u32 segment_size;
>> +
>> +       mutex_lock(&opts->lock);
>> +       segment_size = opts->max_segment_size;
>> +       mutex_unlock(&opts->lock);
>> +
>> +       return sprintf(page, "%u\n", segment_size);
>> +}
>> +
>> +static ssize_t ncm_opts_max_segment_size_store(struct config_item *item,
>> +                                               const char *page, size_t len)
>> +{
>> +       struct f_ncm_opts *opts = to_f_ncm_opts(item);
>> +       int ret;
>> +       u32 segment_size;
>> +
>> +       mutex_lock(&opts->lock);
>> +       if (opts->refcnt) {
>> +               ret = -EBUSY;
>> +               goto out;
>> +       }
>> +
>> +       ret = kstrtou32(page, 0, &segment_size);
>> +       if (ret)
>> +               goto out;
>> +
>> +       if (segment_size > MAX_DATAGRAM_SIZE) {
>> +               ret = -EINVAL;
>> +               goto out;
>> +       }
>> +
>> +       opts->max_segment_size = segment_size;
>> +       ret = len;
>> +out:
>> +       mutex_unlock(&opts->lock);
>> +       return ret;
>> +}
>> +
>> +CONFIGFS_ATTR(ncm_opts_, max_segment_size);
>> +
>>   static struct configfs_attribute *ncm_attrs[] = {
>>          &ncm_opts_attr_dev_addr,
>>          &ncm_opts_attr_host_addr,
>>          &ncm_opts_attr_qmult,
>>          &ncm_opts_attr_ifname,
>> +       &ncm_opts_attr_max_segment_size,
>>          NULL,
>>   };
>>
>> @@ -1633,6 +1687,7 @@ static struct usb_function_instance *ncm_alloc_inst(void)
>>                  kfree(opts);
>>                  return ERR_CAST(net);
>>          }
>> +       opts->max_segment_size = cpu_to_le16(ETH_FRAME_LEN);
>>          INIT_LIST_HEAD(&opts->ncm_os_desc.ext_prop);
>>
>>          descs[0] = &opts->ncm_os_desc;
>> diff --git a/drivers/usb/gadget/function/u_ncm.h b/drivers/usb/gadget/function/u_ncm.h
>> index 5408854d8407..fab99d997476 100644
>> --- a/drivers/usb/gadget/function/u_ncm.h
>> +++ b/drivers/usb/gadget/function/u_ncm.h
>> @@ -31,6 +31,7 @@ struct f_ncm_opts {
>>           */
>>          struct mutex                    lock;
>>          int                             refcnt;
>> +       u32                             max_segment_size;
>>   };
>>
>>   #endif /* U_NCM_H */
>> --
>> 2.39.0
>>
