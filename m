Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775365E5AC7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 07:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiIVFgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 01:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiIVFgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 01:36:17 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397D8B07D3;
        Wed, 21 Sep 2022 22:36:16 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28M4l6cn020296;
        Thu, 22 Sep 2022 05:36:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type : subject :
 from : in-reply-to : date : cc : message-id : references : to :
 content-transfer-encoding : mime-version; s=pp1;
 bh=1VkmmVMcotah7R98FCFQ+CstXcddcst1nSO+Q2M3PiE=;
 b=Me+ADMAj6WpkngtMnAFwYoZqKblg7yFMPXOzN/p7szQX6tW3rjyL6v3vVemFufbA+A57
 4WnNe3Pz9S/KguJ6aD4fiwRFN4wssfNPptNYEUAm9Owmb/o62Jl6T03jOagap1KgDfVt
 80RrNhRCvgRTzdoopm4+EgGqHHj3vAfUl2rGPI9fKsMITF79+O20v5iT//SXTTXstEZv
 rphLMk+w2AGR1WICcHXkhKlXL4k88I57X/h2WtQOZxNdjH2nBGxsGpnWCdNX/CxHCs1e
 lCemA9Oe3Y7GeP/G7UDboJrE1abD0EONPapC2WH+TGtgdmRGDAlx7ZSeqd+D7OHvEmYB yg== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jrh01sa8j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Sep 2022 05:36:13 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28M5L9Gl001349;
        Thu, 22 Sep 2022 05:31:11 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3jn5gj63t1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Sep 2022 05:31:11 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28M5VZ8D40370454
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Sep 2022 05:31:35 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F2FBA404D;
        Thu, 22 Sep 2022 05:31:09 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0CAC7A4053;
        Thu, 22 Sep 2022 05:31:08 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.104.67])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 22 Sep 2022 05:31:07 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Subject: Re: [PATCH] scsi: scsi_transport_fc: Adjust struct fc_nl_event flex
 array usage
From:   Sachin Sant <sachinp@linux.ibm.com>
In-Reply-To: <20220921205155.1451649-1-keescook@chromium.org>
Date:   Thu, 22 Sep 2022 11:01:06 +0530
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Message-Id: <AD7C74D0-D13E-479E-91D1-2FB3B6CD85FE@linux.ibm.com>
References: <20220921205155.1451649-1-keescook@chromium.org>
To:     Kees Cook <keescook@chromium.org>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SJntG_tunA7ccnyJmdSvKxK4C188Hfbe
X-Proofpoint-GUID: SJntG_tunA7ccnyJmdSvKxK4C188Hfbe
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-22_02,2022-09-20_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 clxscore=1011
 spamscore=0 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209220036
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 22-Sep-2022, at 2:21 AM, Kees Cook <keescook@chromium.org> wrote:
>=20
> In order to help the compiler reason about the destination buffer in
> struct fc_nl_event, add a flexible array member for this purpose.
> However, since the header is UAPI, it must not change size or layout, so
> a union is used.
>=20
> The allocation size calculations are also corrected (it was potentially
> allocating an extra 8 bytes), and the padding is zeroed to avoid leaking
> kernel heap memory contents.
>=20
> Detected at run-time by the recently added memcpy() bounds checking:
>=20
>  memcpy: detected field-spanning write (size 8) of single field "&event->=
event_data" at drivers/scsi/scsi_transport_fc.c:581 (size 4)
>=20
> Reported-by: Sachin Sant <sachinp@linux.ibm.com>
> Link: https://lore.kernel.org/linux-next/42404B5E-198B-4FD3-94D6-5E16CF57=
9EF3@linux.ibm.com/
> Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: linux-scsi@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---

Thanks for the fix. With this patch applied the warning is no longer seen.

Tested-by: Sachin Sant <sachinp@linux.ibm.com>

> drivers/scsi/scsi_transport_fc.c    | 8 +++++---
> include/uapi/scsi/scsi_netlink_fc.h | 7 +++++--
> 2 files changed, 10 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/scsi/scsi_transport_fc.c b/drivers/scsi/scsi_transpo=
rt_fc.c
> index a2524106206d..0d798f11dc34 100644
> --- a/drivers/scsi/scsi_transport_fc.c
> +++ b/drivers/scsi/scsi_transport_fc.c
> @@ -543,7 +543,7 @@ fc_host_post_fc_event(struct Scsi_Host *shost, u32 ev=
ent_number,
> 	struct nlmsghdr	*nlh;
> 	struct fc_nl_event *event;
> 	const char *name;
> -	u32 len;
> +	size_t len, padding;
> 	int err;
>=20
> 	if (!data_buf || data_len < 4)
> @@ -554,7 +554,7 @@ fc_host_post_fc_event(struct Scsi_Host *shost, u32 ev=
ent_number,
> 		goto send_fail;
> 	}
>=20
> -	len =3D FC_NL_MSGALIGN(sizeof(*event) + data_len);
> +	len =3D FC_NL_MSGALIGN(sizeof(*event) - sizeof(event->event_data) + dat=
a_len);
>=20
> 	skb =3D nlmsg_new(len, GFP_KERNEL);
> 	if (!skb) {
> @@ -578,7 +578,9 @@ fc_host_post_fc_event(struct Scsi_Host *shost, u32 ev=
ent_number,
> 	event->event_num =3D event_number;
> 	event->event_code =3D event_code;
> 	if (data_len)
> -		memcpy(&event->event_data, data_buf, data_len);
> +		memcpy(event->event_data_flex, data_buf, data_len);
> +	padding =3D len - offsetof(typeof(*event), event_data_flex) - data_len;
> +	memset(event->event_data_flex + data_len, 0, padding);
>=20
> 	nlmsg_multicast(scsi_nl_sock, skb, 0, SCSI_NL_GRP_FC_EVENTS,
> 			GFP_KERNEL);
> diff --git a/include/uapi/scsi/scsi_netlink_fc.h b/include/uapi/scsi/scsi=
_netlink_fc.h
> index 7535253f1a96..b46e9cbeb001 100644
> --- a/include/uapi/scsi/scsi_netlink_fc.h
> +++ b/include/uapi/scsi/scsi_netlink_fc.h
> @@ -35,7 +35,7 @@
>  * FC Transport Broadcast Event Message :
>  *   FC_NL_ASYNC_EVENT
>  *
> - * Note: if Vendor Unique message, &event_data will be  start of
> + * Note: if Vendor Unique message, event_data_flex will be start of
>  * 	 vendor unique payload, and the length of the payload is
>  *       per event_datalen
>  *
> @@ -50,7 +50,10 @@ struct fc_nl_event {
> 	__u16 event_datalen;
> 	__u32 event_num;
> 	__u32 event_code;
> -	__u32 event_data;
> +	union {
> +		__u32 event_data;
> +		__DECLARE_FLEX_ARRAY(__u8, event_data_flex);
> +	};
> } __attribute__((aligned(sizeof(__u64))));
>=20
>=20
> --=20
> 2.34.1
>=20

