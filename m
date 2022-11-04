Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D3A61A425
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 23:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiKDWiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 18:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKDWiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 18:38:19 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CEB2FC24;
        Fri,  4 Nov 2022 15:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1667601498; x=1699137498;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wsU+aHAPL6wI9VTXb6yNVacRzmtrJE6X1htelu1J7e8=;
  b=l0/x7R6Q4Np+x2J4SeiDI319iA9+eM+7JdQ/Sud81DoSheR4qzwAj0Wv
   r6n/JlbBHYzZ5WRjDHBvKMZ6nRG6wbttqAT/mbAtkjjVq3dJrw4azjTCu
   HvmbjMMP3bmKjK9rlRm9CvdEu8w8nQfMLjNx5ajfs36JX/TxqvnPAAOj+
   o=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 04 Nov 2022 15:38:18 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 15:38:17 -0700
Received: from [10.110.122.8] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 4 Nov 2022
 15:38:16 -0700
Message-ID: <980db147-794e-ecd9-9626-64ff81109bab@quicinc.com>
Date:   Fri, 4 Nov 2022 15:38:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v6 13/21] gunyah: vm_mgr: Introduce basic VM Manager
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Srivatsa Vaddagiri" <quic_svaddagi@quicinc.com>,
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
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <9dd597d9-a3f3-48f2-8416-b5b097a230d5@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/4/2022 1:10 AM, Arnd Bergmann wrote:
> On Fri, Nov 4, 2022, at 01:11, Elliot Berman wrote:
>> On 11/2/2022 5:24 PM, Greg Kroah-Hartman wrote:
>>> On Wed, Nov 02, 2022 at 11:45:12AM -0700, Elliot Berman wrote:
>>>
>>> Even if you don't support it 1:1, at least for the ones that are the
>>> same thing, pick the same numbers as that's a nicer thing to do, right?
>>>
>>
>> Does same thing == interpretation of arguments is the same? For
>> instance, GH_CREATE_VM and KVM_CREATE_VM interpret the arguments
>> differently. Same for KVM_SET_USERSPACE_MEMORY. The high level
>> functionality should be similar for most all hypervisors since they will
>> all support creating a VM and probably sharing memory with that VM. The
>> arguments for that will necessarily look similar, but they will probably
>> be subtly different because the hypervisors support different features.
> 
> I think in the ideal case, you should make the arguments and the
> command codes the same for any command where that is possible. If
> you come across a command that is shared with KVM but just needs
> another flag, that would involve coordinating with the KVM maintainers
> about sharing the definition so the same flag does not get reused
> in an incompatible way.
> 

I think the converse also needs to be true; KVM would need to check that
new flags don't get used in some incompatible way with Gunyah, even if
one of us is just -EINVAL'ing. I don't think Gunyah and KVM should be
reliant on the other reviewing shared ioctls.

The problem is a bit worse because "machine type" is architecture-
dependent whereas the planned Gunyah flags are architecture-independent.
KVM within itself re-uses flags between architectures so Gunyah would
need to reserve some flags from all architectures that KVM supports.

> For commands that cannot fit into the existing definition, there
> should be a different command code, using your own namespace and
> not the 0xAE block that KVM has. It still makes sense to follow
> the argument structure roughly here, unless there is a technical
> reason for making it different.
> 
>> I don't think userspace that supports both KVM and Gunyah will benefit
>> much from re-using the same numbers since those re-used ioctl calls
>> still need to sit within the context of a Gunyah VM.
> 
> One immediate benefit is for tools that work on running processes,
> such as strace, gdb or qemu-user. If they encounter a known command,
> they can correctly display the arguments etc.
> 

We can update these tools and anyway there will be different ioctls to
get started. There are important ioctls that wouldn't be correctly
displayed off the bat anyway; work would need to be done to support the
Gunyah ioctls either way. Whereas tooling update is temporary, the
coupling of KVM and Gunyah ioctls would be permanent.

> Another benefit is for sharing portions of the VMM that live in
> outside processes like vhost-user based device emulation that
> interacts with irqfd, memfd etc. The more similar the command
> interface is, the easier it gets to keep these tools portable.
> 

Hypervisor interfaces already have different ioctls for equivalent
functionality [1], so VMMs that want to scale to multiple hypervisors
already abstract out ioctl-level interfaces so there wouldn't be any
code-reuse even if Gunyah and KVM shared the same ioctl number. Between
hypervisors, the best case is there is design similarity for userspace,
which makes it easier to add new hypervisor support for VMMs and that's
what we are aiming for.

[1]: e.g. compare KVM, acrn, xen for implementing virtual interrupts.
KVM and acrn use independently implemented irqfd interfaces, xen has
totally different implementation called event channels.

Thanks,
Elliot
