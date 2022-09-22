Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330595E6FC4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 00:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiIVWem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 18:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiIVWe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 18:34:27 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CB0F9624;
        Thu, 22 Sep 2022 15:34:26 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28MHV1VG032713;
        Thu, 22 Sep 2022 15:34:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=pfpt0220; bh=SSbXnJllTcSdwV1OjvT1gPaK/LBACiszJevnCuno0qA=;
 b=DEq1Jpy3GENGSt83MZEziFApU4j5wTlF8/HwiAtKNd4/iGuJDazU/veSxH6dAw4OZZJC
 F93bf68/nWIboibGa1M5vAntNAiY2/bIQdCpHfxsjlMtcJ9Ycy34L4n0/Q8MjetPNHqp
 Bs7TYBhBEXvrM+4rPyGNKuPWhUEGap2K9UJdJbud+MT5nFFUH4junod7sAcQnc1iNomf
 F37DBQaIxboI/x+wBPxvE6/Hv8lMncKhYJNZB3RuCo4JCYe/ReeMgjUsB0dldxizdV04
 92P7Vyeha9DSM0yLsZhJmEjL+1lRYf+t/JGBHaK2qG7h6Z/8KMf2LHbQodCZNkg0YvEI Bg== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3jr1qmq727-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 22 Sep 2022 15:34:16 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 22 Sep
 2022 15:34:14 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Thu, 22 Sep 2022 15:34:14 -0700
Received: from mvluser05.qlc.com (unknown [10.112.10.135])
        by maili.marvell.com (Postfix) with ESMTP id 2F66A3F7089;
        Thu, 22 Sep 2022 15:34:14 -0700 (PDT)
Received: from localhost (aeasi@localhost)
        by mvluser05.qlc.com (8.14.4/8.14.4/Submit) with ESMTP id 28MMYDiP029376;
        Thu, 22 Sep 2022 15:34:13 -0700
X-Authentication-Warning: mvluser05.qlc.com: aeasi owned process doing -bs
Date:   Thu, 22 Sep 2022 15:34:12 -0700
From:   Arun Easi <aeasi@marvell.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        James Bottomley <jejb@linux.ibm.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-next@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>
Subject: Re: [EXT] Re: [PATCH v3 1/1] tracing: Fix compile error in trace_array
 calls when TRACING is disabled
In-Reply-To: <20220922170204.08f91a68@gandalf.local.home>
Message-ID: <86d9d0f8-ae29-3875-cbf1-b609f4f59421@marvell.com>
References: <20220907233308.4153-1-aeasi@marvell.com>
 <20220907233308.4153-2-aeasi@marvell.com>
 <yq15yho3y0s.fsf@ca-mkp.ca.oracle.com>
 <20220922170204.08f91a68@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-GUID: ezwOTDrCN-KZ8btyCLQnHElypukXsCpy
X-Proofpoint-ORIG-GUID: ezwOTDrCN-KZ8btyCLQnHElypukXsCpy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-22_14,2022-09-22_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review, Steve.

Regards,
-Arun

On Thu, 22 Sep 2022, 2:02pm, Steven Rostedt wrote:

> External Email
> 
> ----------------------------------------------------------------------
> On Thu, 15 Sep 2022 21:32:59 -0400
> "Martin K. Petersen" <martin.petersen@oracle.com> wrote:
> 
> > Steven,
> > 
> > Can you please review Arun's patch?
> 
> Sorry, was busy running a conference ;-)
> 
> > 
> > > Fix this compilation error seen when CONFIG_TRACING is not enabled:
> > >
> > > drivers/scsi/qla2xxx/qla_os.c: In function 'qla_trace_init':
> > > drivers/scsi/qla2xxx/qla_os.c:2854:25: error: implicit declaration of function
> > > 'trace_array_get_by_name'; did you mean 'trace_array_set_clr_event'?
> > > [-Werror=implicit-function-declaration]
> > >  2854 |         qla_trc_array = trace_array_get_by_name("qla2xxx");
> > >       |                         ^~~~~~~~~~~~~~~~~~~~~~~
> > >       |                         trace_array_set_clr_event
> > >
> > > drivers/scsi/qla2xxx/qla_os.c: In function 'qla_trace_uninit':
> > > drivers/scsi/qla2xxx/qla_os.c:2869:9: error: implicit declaration of function
> > > 'trace_array_put' [-Werror=implicit-function-declaration]
> > >  2869 |         trace_array_put(qla_trc_array);
> > >       |         ^~~~~~~~~~~~~~~
> > >  
> > 
> 
> The patch looks good to me.
> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> -- Steve
> 
