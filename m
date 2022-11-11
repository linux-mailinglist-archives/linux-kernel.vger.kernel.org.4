Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C64626025
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 18:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234125AbiKKRJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 12:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234161AbiKKRJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 12:09:11 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A271A3B1;
        Fri, 11 Nov 2022 09:08:58 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ABG8uCs017312;
        Fri, 11 Nov 2022 17:08:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=03eezIBJKpj7j/9qQicis47eqBl7PzCBbko9n8Odntw=;
 b=kOOadAQhlY4zwHKiYPvrmOmjtKiym8vFfjo0fkSROG0rUkDtQG4/T8aLV1abIUNRRNzs
 KVhdJqh2dFX7UKzXv1Ox/GY2tQdSvd1eLiSUv/XOYkCMu6Fo6daP4RF0JQQKLjVpn5Z3
 06TNBkvWXum/MG27j2DpecykoQL5mMYLh3IUR+bzHL8EUDvFQLN+JDFitQNkj6AOYhgN
 pA8yFevS7PrJeUOhqLzVkPq7gFFkkp+v1wKMsovkKAcETJeBRbzRtdFZAK2LAMbVJ+Uq
 8S5+X6FKRDaOjLZ3FzR6w01rGp1hSkOQSN1huXcCXnz2Gc7HtQM7MVZ2qKUKs3+AkMgk 9w== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kshkdhqaw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Nov 2022 17:08:42 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2ABH8fDq023857
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Nov 2022 17:08:41 GMT
Received: from [10.110.50.128] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 11 Nov
 2022 09:08:40 -0800
Message-ID: <e10ca37a-5d02-ce00-423d-18f9a9e6fe0d@quicinc.com>
Date:   Fri, 11 Nov 2022 09:08:40 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v6 13/21] gunyah: vm_mgr: Introduce basic VM Manager
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Trilok Soni <quic_tsoni@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Bjorn Andersson" <quic_bjorande@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Will Deacon" <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Srinivas Kandagatla" <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Kalle Valo <kvalo@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221026185846.3983888-1-quic_eberman@quicinc.com>
 <20221026185846.3983888-14-quic_eberman@quicinc.com>
 <Y2H8oh7AvYDiMqKs@kroah.com>
 <722b05a1-4bf5-0837-baea-b1d0a9cc1e43@quicinc.com>
 <Y2MKWOihjAPxfl6v@kroah.com>
 <96238455-73b6-bead-0fdb-55ca68e5bf0b@quicinc.com>
 <9dd597d9-a3f3-48f2-8416-b5b097a230d5@app.fastmail.com>
 <980db147-794e-ecd9-9626-64ff81109bab@quicinc.com>
 <95a9f253-984a-14e0-7e01-f168452576c4@quicinc.com>
 <543d95f8-be31-7553-4700-5dc04872e8ea@quicinc.com>
 <Y23qjcMmerVuKFdj@kroah.com>
Content-Language: en-US
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <Y23qjcMmerVuKFdj@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9nZnTzysHz-yQwmjXf_a3mkpW5qatf5E
X-Proofpoint-ORIG-GUID: 9nZnTzysHz-yQwmjXf_a3mkpW5qatf5E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-11_08,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 malwarescore=0 mlxscore=0 suspectscore=0
 mlxlogscore=550 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211110115
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/10/2022 10:24 PM, Greg Kroah-Hartman wrote:
> On Thu, Nov 10, 2022 at 04:03:10PM -0800, Elliot Berman wrote:
>>> Agree, tools can be updated and that is the easy part as we grow the s/w
>>> stack around Gunyah in userspace, like we already do w/ CrosVM (Virtual
>>> Machine Manager) and QEMU will be next followed by rust-vmm. All of them
>>> can be done without Gunyah ioctls relying anything on the KVM ioctls.
>>> Elliot has also explained very well that we don't to go to KVM
>>> maintainers for any of our additions and we also don't want them to come
>>> to us, since there is no interoperability testing. It is best that both
>>> Hypervisors and their Linux interfaces evolve independently.
>>
>> Are above explanations reasonable to not re-use KVM ioctl numbers?
> 
> Try getting close at least, where possible please.  As your ioctl
> numbers didn't even start at 0, it's a bit odd...

Ack, will do.

Thanks,
Elliot
