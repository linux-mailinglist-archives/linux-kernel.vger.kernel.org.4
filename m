Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8D05FBD97
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 00:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiJKWEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 18:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiJKWEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 18:04:04 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390471C406;
        Tue, 11 Oct 2022 15:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1665525843; x=1697061843;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=J9/5n4tS46/xKKVi9EpzbSUpnYma+DcmN/Zm80P/0Qc=;
  b=Uf0lYF4O8xYMI93g59hTYRovW0UMwVFWbfKgTgGvqSzDPrc0pEPq4Wqo
   Ti8gsj+GpVtjoKOMLgcYsBE6XXMEMcPoA8k/cunN/pQ6fH7tpSYGX0OD1
   E2E7Fa92Pxg5sif/XgUVOiG5vHb7eP6lKnup4pbEc160/pf0i44j3oZOJ
   0=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 11 Oct 2022 15:04:02 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 15:04:02 -0700
Received: from [10.134.65.5] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 11 Oct
 2022 15:04:01 -0700
Message-ID: <bf9d4365-7750-399f-e488-1611eecca13a@quicinc.com>
Date:   Tue, 11 Oct 2022 15:04:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 13/13] tty: gunyah: Add tty console driver for RM
 Console Services
Content-Language: en-US
To:     Jiri Slaby <jirislaby@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
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
        "Arnd Bergmann" <arnd@arndb.de>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221011000840.289033-1-quic_eberman@quicinc.com>
 <20221011000840.289033-14-quic_eberman@quicinc.com>
 <7438406d-b446-201e-0ec3-5cf0a5b9f32c@kernel.org>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <7438406d-b446-201e-0ec3-5cf0a5b9f32c@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/10/2022 11:02 PM, Jiri Slaby wrote:
> On 11. 10. 22, 2:08, Elliot Berman wrote:
>> Gunyah provides a console for each VM using the VM console resource
>> manager APIs. This driver allows console data from other
>> VMs to be accessed via a TTY device and exports a console device to dump
>> Linux's own logs to our console.
> ...
>> +struct rm_cons_drv_data {
>> +    struct tty_driver *tty_driver;
>> +    struct device *dev;
>> +
>> +    spinlock_t ports_lock;
>> +    struct rm_cons_port *ports[RM_CONS_TTY_ADAPATERS];
>> +
>> +    struct notifier_block rm_cons_notif;
>> +    struct console console;
>> +
>> +    /* below are for printk console.
>> +     * gh_rm_console_* calls will sleep and console_write can be 
>> called from
>> +     * atomic ctx. Two xmit buffers are used. The active buffer is 
>> tracked with
>> +     * co_xmit_idx. Writes go into the co_xmit_buf[co_xmit_idx] buffer.
>> +     * A work is scheduled to flush the bytes. The work will swap the 
>> active buffer
>> +     * and write out the other buffer.
>> +     */
> 
> Ugh, why? This is too ugly and unnecessary. What about passing the kfifo 
> to gh_rm_console_write() instead? You do memcpy() there anyway.
> 

Sure, I can do this instead.
