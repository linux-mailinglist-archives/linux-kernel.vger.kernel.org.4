Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0AD069164A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 02:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjBJBge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 20:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjBJBgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 20:36:32 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0265DC2C;
        Thu,  9 Feb 2023 17:36:30 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31A1EQ7x023355;
        Fri, 10 Feb 2023 01:36:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=gf1WQiKBQwYaE38RO5jpV8WfjKBbW2+FB9Rqw+LNPwY=;
 b=KKuowHJs7BXbYDQ7P0XR4jV82pRpKD0/eBbHRy2A6+oG4TaatkCd4N99C4aoM0krJSDJ
 z1vs3cIppOQ6+iKjuE3WwlsNhlmtzuGollIYmWoUn8qr5SaYsKX1wFJ4+3uzyDqsEBxK
 yU33brf4q1z3XDyTjyxT90dZVtapuCxmY3Gjs1hl1LJLe8fr3YZZNMlSAedThG0wUm91
 QDeRJhG9amoE2MApZGgVPLhXsYMbsMtdWPTXv9q46ZE+XGIh6zYTP72XXNmQYmKDR4os
 9bZZV2wH6rRFdtkpD3+F5KQsBjIK6fQQYZO6jPun6jVe4WvRgIc0qFnClH5Oxf0di7ZP uA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nm86mvyyf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 01:36:25 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31A1aPWv015933
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 01:36:25 GMT
Received: from [10.110.96.245] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 9 Feb 2023
 17:36:24 -0800
Message-ID: <28322f07-de6b-81e0-38c5-c856d5ce2dce@quicinc.com>
Date:   Thu, 9 Feb 2023 17:36:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 2/5] usb: dwc3: Add remote wakeup handling
Content-Language: en-US
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
References: <1675710806-9735-1-git-send-email-quic_eserrao@quicinc.com>
 <1675710806-9735-3-git-send-email-quic_eserrao@quicinc.com>
 <20230207004833.tuy52evcgk7sfa4q@synopsys.com>
 <9bcf323a-5660-da47-dd6c-b218f7f26a45@quicinc.com>
 <20230208011017.47o7m3xt63lbih3m@synopsys.com>
 <cd143a99-f781-fd32-cad2-3df8f8c0d617@quicinc.com>
 <20230208021127.syauhdtpbyyncixr@synopsys.com>
From:   Elson Serrao <quic_eserrao@quicinc.com>
In-Reply-To: <20230208021127.syauhdtpbyyncixr@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UknoGDqjV5ryVXpzbJSD0ZlXjNVCGseF
X-Proofpoint-ORIG-GUID: UknoGDqjV5ryVXpzbJSD0ZlXjNVCGseF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-09_17,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302100012
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/7/2023 6:11 PM, Thinh Nguyen wrote:
> On Tue, Feb 07, 2023, Elson Serrao wrote:
>>
>>
>> On 2/7/2023 5:10 PM, Thinh Nguyen wrote:
>>> On Tue, Feb 07, 2023, Elson Serrao wrote:
>>>> On 2/6/2023 4:48 PM, Thinh Nguyen wrote:
>>>>>> +static int __dwc3_gadget_wakeup(struct dwc3 *dwc, bool async)
>>>>>>     {
>>>>>>     	int			retries;
>>>>>> @@ -2296,9 +2309,14 @@ static int __dwc3_gadget_wakeup(struct dwc3 *dwc)
>>>>>>     	link_state = DWC3_DSTS_USBLNKST(reg);
>>>>>>     	switch (link_state) {
>>>>>> +	case DWC3_LINK_STATE_U3:	/* in HS, means SUSPEND */
>>>>>
>>>>> It's also possible to do remote wakeup in L1 for highspeed.
>>>>>
>>>>
>>>> The rw_configured flag here is in context of triggering remote wakeup from
>>>> bus suspend only.
>>>>
>>>> The remote wakeup setting for l1 in HighSpeed is controlled through LPM
>>>> token and overrides/ignores the config desc bmAttributes wakeup bit.
>>>>
>>>> Section 4.1 of USB2_LinkPowerMangement_ECN[final] spec "The host system sets the Remote Wake Flag parameter in this request to
>>>> enable or disable the addressed device
>>>> for remote wake from L1. The value of this flag will temporarily (while in
>>>> L1) override the current setting of the
>>>> Remote Wake feature settable by the standard Set/ClearFeature() commands
>>>> defined in Universal Serial Bus Specification, revision 2.0, Chapter 9."
>>>>
>>>> Please let me know if I am missing something.
>>>>
>>>
>>> It overrides the setting of the SetFeature request, not the device
>>> configuration.
>>>
>>> The rw_configured reflects the user configuration. Whether the host
>>> tries to enable the remote wakeup through SetFeature request or LPM
>>> token, the device should operate within the user configuration
>>> limitation.
>>>
>>> If the configuration indicates that it doesn't support remote wakeup, we
>>> should prevent unexpected behavior from the device. For simplicity, we
>>> can just return failure to wakeup for all states.
>>>
>>> Thanks,
>>> Thinh
>>
>> L1 entry/exit is HW controlled and the remote wakeup is conditional.(Section
>> 7.1/Table7.2 of dwc3 data book). Even though we block it from
>> SW the l1 exit will still happen from HW point of view.
>>
>> To correlate the user configuration with LPM token, I experimented by
>> disabling the wakeup bit in the bmAtrributes, but I still see remote wakeup
>> bit being set in the LPM token. From the observation it seems like there is
> 
> That's because the linux xhci driver enables remote wakeup bit in its
> port without regard for the device configuration.
> 
>> no correlation between the wakeup bit in the bmAtrributes and the wakeup bit
>> in the LPM token.
>>
> 
> The host can bring the device out of L1, that's probably what you saw.
> The controller doesn't initiate remote wakeup by itself.
> 
> Thanks,
> Thinh

Actually it seems the controller is initiating a remote wakeup by itself 
to exit from l1 when we send a STARTTRANSFER command. I did below 
experiment when the device was in HighSpeed

1.) Enabled l1.
2.) Disabled the remote wakeup software path (i.e avoid calling 
__gadget_wakeup() if link is in l1 in the gadget_ep_cmd() path).
3.) Sent an IN packet when the link was in l1.

 From the lecroy logs it looks like the controller initiated a remote 
wakeup and sent the data.

Below are the events and the corresponding lecroy snippet
1.)Packet(55551) ------------> LPM token from Windows Host PC.

2.) Link in l1 for 2.445 secs

3. ) Send a ping data from device to host

4. )Packet(55554) ----------------> Resume

5.) IN data


Packet#
_______|_______________________________________________________________________
Transaction(26584) H(S) EXT(0x0F) LPM(0xC3) ADDR(11) ENDP(0) BESL(150 us)
_______| Link State(0x1) Rem Wake(0x1) ACK(0x4B) Time Stamp(27 . 204 671 
632)
_______|_______________________________________________________________________Ch0 

Packet(55550) Dir H(S) EXT(0x0F) ADDR(11) ENDP(0) CRC5(0x04) Pkt Len(8)
_______| Duration(133.330 ns) Idle(200.660 ns) Time Stamp(27 . 204 671 632)
_______|_______________________________________________________________________Ch0 

Packet(55551) Dir H(S) LPM(0xC3) BESL(150 us) Link State(0x1)
_______| Rem Wake(0x1) Rsvd(0x0) CRC5(0x04) Pkt Len(8) Duration(133.330 ns)
_______| Idle(182.660 ns) Time Stamp(27 . 204 671 966)
_______|_______________________________________________________________________Ch0 

Packet(55552) Dir H(S) ACK(0x4B) Pkt Len(6) Duration(100.000 ns)
_______| Idle( 11.450 us) Time Stamp(27 . 204 672 282)
_______|_______________________________________________________________________Ch0 

Packet(55553) Dir(?) Full Speed J (Suspend)( 2.445 sec)
_______| Time Stamp(27 . 204 683 832)
_______|_______________________________________________________________________Ch0 

Packet(55554) Dir(?) Full Speed K (Resume?)( 95.168 us) Time(165.134 us)
_______| Time Stamp(29 . 649 644 482)
_______|_______________________________________________________________________
Transfer(67) H(S) Bulk(IN) ADDR(11) ENDP(1) Bytes Transferred(142)
_______| Time(309.366 us) Time Stamp(29 . 649 809 616)
_______|_______________________________________________________________________
Transfer(68) H(S) Bulk(OUT) ADDR(11) ENDP(1) Bytes Transferred(142)
_______| Time(520.050 us) Time Stamp(29 . 650 118 982)
_______|_______________________________________________________________________
Transaction(26655) H(S) EXT(0x0F) LPM(0xC3) ADDR(11) ENDP(0) BESL(150 us)
_______| Link State(0x1) Rem Wake(0x1) ACK(0x4B) Time( 12.168 us)
_______| Time Stamp(29 . 650 639 032)
_______|_______________________________________________________________________

If software was solely responsible for waking up from l1, then there 
should be no reason why the host would exit l1 in this scenario.
I tried with different ping intervals and saw that the duration for 
which the link was in l1 correlates with the ping interval.

Thanks
Elson
