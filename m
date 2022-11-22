Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBBAB6334C6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 06:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiKVFkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 00:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiKVFko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 00:40:44 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D6018B12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 21:40:43 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AM4pCQN004971;
        Tue, 22 Nov 2022 05:40:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=gLzUpKnzsNYq8BtGIgiOU2OHutEvCzzxfuMx9ZEF6Z4=;
 b=k0hdga73BBEKgvjO74w7PhbuMNyAb4/rHeQc/tiqxJ0BlhldvM5idXhIlIMN/M9UkZqY
 YenJNcfpMmoVGTuI8uSjEWgwPalrj26j+yuwxibyeJLfLnuROX/N5Qz+wteYEbhfmD4I
 kEko+5YvaJm3TVzx4g2qaCV3RjJZyNYq8TO2bq5Vmdd+id0bNJmFAvnhrDgpWVCAzwWn
 0k6aMX9uco92JuiRQInerl+op9P/y3942mE9GjSewz6ZJr6+Fke/Hzps8nD3IljAWUtz
 /+8V290KBKgrUZINuN/RtvKf9RcMXTdXLQZJJhFXumL1N6M0nbdLYDeqNC9tEo06OvIi 8Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m0hqk0p76-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Nov 2022 05:40:30 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AM5Nt7I023423;
        Tue, 22 Nov 2022 05:40:29 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m0hqk0p69-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Nov 2022 05:40:29 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AM5Yrra023692;
        Tue, 22 Nov 2022 05:40:27 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04fra.de.ibm.com with ESMTP id 3kxps8tpby-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Nov 2022 05:40:27 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AM5ePT926804574
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Nov 2022 05:40:25 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E696F52051;
        Tue, 22 Nov 2022 05:40:24 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 91A7352052;
        Tue, 22 Nov 2022 05:40:24 +0000 (GMT)
Received: from [10.61.2.128] (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id C4B5C600F3;
        Tue, 22 Nov 2022 16:40:14 +1100 (AEDT)
Message-ID: <14aca800f33d1b347d0b942fc39b022006e2a65d.camel@linux.ibm.com>
Subject: Re: [PATCH] cxl: Fix refcount leak in cxl_calc_capp_routing
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Miaoqian Lin <linmq006@gmail.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Lombard <clombard@linux.vnet.ibm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Date:   Tue, 22 Nov 2022 16:39:59 +1100
In-Reply-To: <f818d7f2-eeae-8a98-30a6-0c47bef9462e@csgroup.eu>
References: <20220605060038.62217-1-linmq006@gmail.com>
         <269ecf828ebaa4212a5be6310619aba6d8cfe41d.camel@linux.ibm.com>
         <f818d7f2-eeae-8a98-30a6-0c47bef9462e@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GMIuw7NmlagnTsuhC5Y1-qES3MT-0xOd
X-Proofpoint-GUID: 68uSR8wx7cjia_2h0qcXGcLoTpMcbDEB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-22_02,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 impostorscore=0 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211220040
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-11-14 at 12:42 +0000, Christophe Leroy wrote:
> Should this be applied by Bjorn as most recent changes to that file ?

We usually take cxl patches through powerpc, though sometimes Greg
picks them up through char-misc.

--=20
Andrew Donnellan    OzLabs, ADL Canberra
ajd@linux.ibm.com   IBM Australia Limited
