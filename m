Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1906367BD58
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 21:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235896AbjAYUtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 15:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235065AbjAYUte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 15:49:34 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18648694;
        Wed, 25 Jan 2023 12:49:30 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PKWIU7023790;
        Wed, 25 Jan 2023 20:49:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=xACmOZ4ukkAcUmVvUM2aiIZYmP4ylYGfvpEzRuo+ADQ=;
 b=hirsF36WmOnPPiLYEfT6z5x6zLQ1iZpDCo7XmAKUfIL6XSumL0YUs3i3F9uyouDnaSPk
 6Scp64RlrxjUlTz1UnFyCJVohIo3/uXhF1Zz3hWC8LUIrr++Ght3mki78+0BfFJr3Zve
 kLOOKiFtVYk1+hgkvIL8pdXTf9+znDpX8TCgeQbsQfgZ6Fkn2aJxJlq3se1qpdFMvzwT
 6SoAt7qg0udHpUBqWZfPRDa6K+r/0PKF1oS5i2lN3uaEUkvS5KD1disivs7imrewhbpM
 SazazOUnjyoa2uMwgULeZ7jXVqWH8UDRBrvAX/KMVDmIzdorsQVsTjKqlQEsBctSEuOm 3Q== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nak7jjnrq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 20:49:21 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30PKnKW1029109
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 20:49:20 GMT
Received: from jackp-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 25 Jan 2023 12:49:19 -0800
Date:   Wed, 25 Jan 2023 12:49:11 -0800
From:   Jack Pham <quic_jackp@quicinc.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Pavan Kondeti <quic_pkondeti@quicinc.com>,
        Pratham Pratap <quic_ppratap@quicinc.com>,
        "Harsh Agarwal" <quic_harshq@quicinc.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        "quic_shazhuss@quicinc.com" <quic_shazhuss@quicinc.com>
Subject: Re: [RFC v4 2/5] usb: dwc3: core: Refactor PHY logic to support
 Multiport Controller
Message-ID: <20230125204911.GA2657@jackp-linux.qualcomm.com>
References: <20230115114146.12628-1-quic_kriskura@quicinc.com>
 <20230115114146.12628-3-quic_kriskura@quicinc.com>
 <20230119003619.ane3weigd4ebsta6@synopsys.com>
 <7fa2d7b0-509d-ae90-4208-6f0245f927f7@quicinc.com>
 <20230120010226.wjwtisj4id6frirl@synopsys.com>
 <91fa86d8-f443-db13-1544-73e2dd50d964@quicinc.com>
 <20230120224400.77t2j3qtcdfqwt5s@synopsys.com>
 <0d9eab77-ad5f-be23-8ed6-d78c0d3ccef1@quicinc.com>
 <20230125190805.l7yo5lls7gfhoo4b@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230125190805.l7yo5lls7gfhoo4b@synopsys.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Z-C9IGQCNa0z5KoXaTsC96qJO6MLpGlF
X-Proofpoint-ORIG-GUID: Z-C9IGQCNa0z5KoXaTsC96qJO6MLpGlF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_13,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 mlxlogscore=799
 priorityscore=1501 mlxscore=0 phishscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301250185
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 07:08:10PM +0000, Thinh Nguyen wrote:

<snip>

> > +       /*
> > +        * If the controller is not host-only, then it must be a
> > +        * single port controller.
> > +        */

Thinh, is this a correct assumption?  Is it possible for the IP to be
synthesized to support both dual-role and multiple ports?  We know that
when operating in device mode only the first port can be used but the
additional ports would be usable when in host.

Thanks,
Jack

> > +       temp = readl(regs + DWC3_GHWPARAMS0);
> > +       hw_mode = DWC3_GHWPARAMS0_MODE(temp);
> > +       if (hw_mode != DWC3_GHWPARAMS0_MODE_HOST) {
> > +               dwc->num_ports = 1;
> > +               dwc->num_ss_ports = 1;
> > +               return 0;
> > +       }
> 
> This check should be done before we get into this function.
