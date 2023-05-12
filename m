Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8637700DC1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 19:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237934AbjELRSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 13:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236079AbjELRSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 13:18:47 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F058A4B;
        Fri, 12 May 2023 10:18:45 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CDb9eX032268;
        Fri, 12 May 2023 17:18:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=/yNHFlCv0grlgkGqCSBZdJCbecs4ORkISiyBaYDOeug=;
 b=Os/JPW0ugfnVYoj7g0gmZQ2BTvJ5sSeIqvXoproulbID4HbMRyAj2ZQ20dBa8cA66hnN
 ANsr+Evhf4SXmyJLxm5zPU4bRLObhYCojcHS29umizp+6kFj2RD0dx0TMqg4S2BLndkx
 IUwD+cPePa4sWDdtIRRCWaUFtgPjUZyc2L3aY+Qj5+b4b4gKfnrn41jyrC/SGFU1UnF8
 uImCCDG5zOUYTz2k+2FmEMpR8Xl3l/0SYKYqn3e1OxAakSf3nVg+ykUXI77AxLFOV6y7
 U3rVx3cYmYUfeE/2XDAaLaWDToifubN5ii8E0c2ZO8ieMXP5Lk3hge0Jq/nHudDlfII8 qg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qhh3918nw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 17:18:31 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34CHIUcf008775
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 17:18:30 GMT
Received: from [10.71.115.228] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 12 May
 2023 10:18:29 -0700
Message-ID: <c7d4c1d4-f337-a425-bf0d-f7b0f03dab7c@quicinc.com>
Date:   Fri, 12 May 2023 10:18:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/2] usb: dwc3: Modify runtime pm ops to handle bus
 suspend
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        <oe-kbuild@lists.linux.dev>, <gregkh@linuxfoundation.org>,
        <Thinh.Nguyen@synopsys.com>
CC:     <lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <quic_wcheng@quicinc.com>, <quic_jackp@quicinc.com>
References: <3e035312-3c06-44e1-95ef-0a4d36456a7d@kili.mountain>
From:   Elson Serrao <quic_eserrao@quicinc.com>
In-Reply-To: <3e035312-3c06-44e1-95ef-0a4d36456a7d@kili.mountain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rCfticNtVnhe3hsAXeSR5w7wdX8uP7Le
X-Proofpoint-ORIG-GUID: rCfticNtVnhe3hsAXeSR5w7wdX8uP7Le
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_10,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 clxscore=1011 mlxscore=0 impostorscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120144
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/11/2023 9:18 PM, Dan Carpenter wrote:
> Hi Elson,
> 
> kernel test robot noticed the following build warnings:
> 
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Elson-Roy-Serrao/usb-function-u_ether-Handle-rx-requests-during-suspend-resume/20230512-015036
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> patch link:    https://lore.kernel.org/r/1683827311-1462-3-git-send-email-quic_eserrao%40quicinc.com
> patch subject: [PATCH 2/2] usb: dwc3: Modify runtime pm ops to handle bus suspend
> config: x86_64-randconfig-m001 (https://download.01.org/0day-ci/archive/20230512/202305120709.tCFYCtsd-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <error27@gmail.com>
> | Link: https://lore.kernel.org/r/202305120709.tCFYCtsd-lkp@intel.com/
> 
> New smatch warnings:
> drivers/usb/dwc3/gadget.c:2409 dwc3_gadget_wakeup() warn: pm_runtime_get_sync() also returns 1 on success
> drivers/usb/dwc3/gadget.c:2437 dwc3_gadget_func_wakeup() warn: pm_runtime_get_sync() also returns 1 on success
> 
> Old smatch warnings:
> drivers/usb/dwc3/gadget.c:1648 __dwc3_gadget_kick_transfer() warn: missing error code? 'ret'
> drivers/usb/dwc3/gadget.c:2744 dwc3_gadget_pullup() warn: pm_runtime_get_sync() also returns 1 on success
> 
> vim +2409 drivers/usb/dwc3/gadget.c
> 
> 218ef7b647e336 Felipe Balbi     2016-04-04  2392  static int dwc3_gadget_wakeup(struct usb_gadget *g)
> 218ef7b647e336 Felipe Balbi     2016-04-04  2393  {
> 218ef7b647e336 Felipe Balbi     2016-04-04  2394  	struct dwc3		*dwc = gadget_to_dwc(g);
> 218ef7b647e336 Felipe Balbi     2016-04-04  2395  	unsigned long		flags;
> 218ef7b647e336 Felipe Balbi     2016-04-04  2396  	int			ret;
> 218ef7b647e336 Felipe Balbi     2016-04-04  2397
> 047161686b813a Elson Roy Serrao 2023-03-24  2398  	if (!dwc->wakeup_configured) {
> 047161686b813a Elson Roy Serrao 2023-03-24  2399  		dev_err(dwc->dev, "remote wakeup not configured\n");
> 047161686b813a Elson Roy Serrao 2023-03-24  2400  		return -EINVAL;
> 047161686b813a Elson Roy Serrao 2023-03-24  2401  	}
> 047161686b813a Elson Roy Serrao 2023-03-24  2402
> 047161686b813a Elson Roy Serrao 2023-03-24  2403  	if (!dwc->gadget->wakeup_armed) {
> 047161686b813a Elson Roy Serrao 2023-03-24  2404  		dev_err(dwc->dev, "not armed for remote wakeup\n");
> 047161686b813a Elson Roy Serrao 2023-03-24  2405  		return -EINVAL;
> 047161686b813a Elson Roy Serrao 2023-03-24  2406  	}
> 047161686b813a Elson Roy Serrao 2023-03-24  2407
> 0660b8a88d4d6a Elson Roy Serrao 2023-05-11  2408  	ret = pm_runtime_get_sync(dwc->dev);
> 0660b8a88d4d6a Elson Roy Serrao 2023-05-11 @2409  	if (ret) {
> 
> The checker is correct.  These days it's better to use the
> pm_runtime_resume_and_get() function instead of pm_runtime_get_sync().
> 

Sure.Thanks!

> 0660b8a88d4d6a Elson Roy Serrao 2023-05-11  2410  		pm_runtime_put(dwc->dev);
> 0660b8a88d4d6a Elson Roy Serrao 2023-05-11  2411  		return ret;
> 0660b8a88d4d6a Elson Roy Serrao 2023-05-11  2412  	}
> 0660b8a88d4d6a Elson Roy Serrao 2023-05-11  2413
> 0660b8a88d4d6a Elson Roy Serrao 2023-05-11  2414  	spin_lock_irqsave(&dwc->lock, flags);
> 0660b8a88d4d6a Elson Roy Serrao 2023-05-11  2415  	ret = __dwc3_gadget_wakeup(dwc, true);
> 72246da40f3719 Felipe Balbi     2011-08-19  2416  	spin_unlock_irqrestore(&dwc->lock, flags);
> 0660b8a88d4d6a Elson Roy Serrao 2023-05-11  2417  	pm_runtime_put_noidle(dwc->dev);
> 72246da40f3719 Felipe Balbi     2011-08-19  2418
> 72246da40f3719 Felipe Balbi     2011-08-19  2419  	return ret;
> 72246da40f3719 Felipe Balbi     2011-08-19  2420  }
> 72246da40f3719 Felipe Balbi     2011-08-19  2421
> 92c08a84b53e5d Elson Roy Serrao 2023-03-24  2422  static void dwc3_resume_gadget(struct dwc3 *dwc);
> 92c08a84b53e5d Elson Roy Serrao 2023-03-24  2423
> 92c08a84b53e5d Elson Roy Serrao 2023-03-24  2424  static int dwc3_gadget_func_wakeup(struct usb_gadget *g, int intf_id)
> 92c08a84b53e5d Elson Roy Serrao 2023-03-24  2425  {
> 92c08a84b53e5d Elson Roy Serrao 2023-03-24  2426  	struct  dwc3		*dwc = gadget_to_dwc(g);
> 92c08a84b53e5d Elson Roy Serrao 2023-03-24  2427  	unsigned long		flags;
> 92c08a84b53e5d Elson Roy Serrao 2023-03-24  2428  	int			ret;
> 92c08a84b53e5d Elson Roy Serrao 2023-03-24  2429  	int			link_state;
> 92c08a84b53e5d Elson Roy Serrao 2023-03-24  2430
> 92c08a84b53e5d Elson Roy Serrao 2023-03-24  2431  	if (!dwc->wakeup_configured) {
> 92c08a84b53e5d Elson Roy Serrao 2023-03-24  2432  		dev_err(dwc->dev, "remote wakeup not configured\n");
> 92c08a84b53e5d Elson Roy Serrao 2023-03-24  2433  		return -EINVAL;
> 92c08a84b53e5d Elson Roy Serrao 2023-03-24  2434  	}
> 92c08a84b53e5d Elson Roy Serrao 2023-03-24  2435
> 0660b8a88d4d6a Elson Roy Serrao 2023-05-11  2436  	ret = pm_runtime_get_sync(dwc->dev);
> 0660b8a88d4d6a Elson Roy Serrao 2023-05-11 @2437  	if (ret) {
> 
> Same.
> 
> 0660b8a88d4d6a Elson Roy Serrao 2023-05-11  2438  		pm_runtime_put(dwc->dev);
> 0660b8a88d4d6a Elson Roy Serrao 2023-05-11  2439  		return ret;
> 0660b8a88d4d6a Elson Roy Serrao 2023-05-11  2440  	}
> 0660b8a88d4d6a Elson Roy Serrao 2023-05-11  2441
> 92c08a84b53e5d Elson Roy Serrao 2023-03-24  2442  	spin_lock_irqsave(&dwc->lock, flags);
> 92c08a84b53e5d Elson Roy Serrao 2023-03-24  2443  	/*
> 92c08a84b53e5d Elson Roy Serrao 2023-03-24  2444  	 * If the link is in U3, signal for remote wakeup and wait for the
> 92c08a84b53e5d Elson Roy Serrao 2023-03-24  2445  	 * link to transition to U0 before sending device notification.
> 92c08a84b53e5d Elson Roy Serrao 2023-03-24  2446  	 */
> 92c08a84b53e5d Elson Roy Serrao 2023-03-24  2447  	link_state = dwc3_gadget_get_link_state(dwc);
> 92c08a84b53e5d Elson Roy Serrao 2023-03-24  2448  	if (link_state == DWC3_LINK_STATE_U3) {
> 92c08a84b53e5d Elson Roy Serrao 2023-03-24  2449  		ret = __dwc3_gadget_wakeup(dwc, false);
> 92c08a84b53e5d Elson Roy Serrao 2023-03-24  2450  		if (ret) {
> 92c08a84b53e5d Elson Roy Serrao 2023-03-24  2451  			spin_unlock_irqrestore(&dwc->lock, flags);
> 0660b8a88d4d6a Elson Roy Serrao 2023-05-11  2452  			pm_runtime_put_noidle(dwc->dev);
> 92c08a84b53e5d Elson Roy Serrao 2023-03-24  2453  			return -EINVAL;
> 92c08a84b53e5d Elson Roy Serrao 2023-03-24  2454  		}
> 92c08a84b53e5d Elson Roy Serrao 2023-03-24  2455  		dwc3_resume_gadget(dwc);
> 92c08a84b53e5d Elson Roy Serrao 2023-03-24  2456  		dwc->link_state = DWC3_LINK_STATE_U0;
> 92c08a84b53e5d Elson Roy Serrao 2023-03-24  2457  	}
> 92c08a84b53e5d Elson Roy Serrao 2023-03-24  2458
> 92c08a84b53e5d Elson Roy Serrao 2023-03-24  2459  	ret = dwc3_send_gadget_generic_command(dwc, DWC3_DGCMD_DEV_NOTIFICATION,
> 92c08a84b53e5d Elson Roy Serrao 2023-03-24  2460  					       DWC3_DGCMDPAR_DN_FUNC_WAKE |
> 92c08a84b53e5d Elson Roy Serrao 2023-03-24  2461  					       DWC3_DGCMDPAR_INTF_SEL(intf_id));
> 92c08a84b53e5d Elson Roy Serrao 2023-03-24  2462  	if (ret)
> 92c08a84b53e5d Elson Roy Serrao 2023-03-24  2463  		dev_err(dwc->dev, "function remote wakeup failed, ret:%d\n", ret);
> 92c08a84b53e5d Elson Roy Serrao 2023-03-24  2464
> 92c08a84b53e5d Elson Roy Serrao 2023-03-24  2465  	spin_unlock_irqrestore(&dwc->lock, flags);
> 0660b8a88d4d6a Elson Roy Serrao 2023-05-11  2466  	pm_runtime_put_noidle(dwc->dev);
> 92c08a84b53e5d Elson Roy Serrao 2023-03-24  2467
> 92c08a84b53e5d Elson Roy Serrao 2023-03-24  2468  	return ret;
> 92c08a84b53e5d Elson Roy Serrao 2023-03-24  2469  }
> 
