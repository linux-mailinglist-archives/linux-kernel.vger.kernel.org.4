Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21986630CFB
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 08:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbiKSHct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 02:32:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiKSHcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 02:32:46 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768AB9B393;
        Fri, 18 Nov 2022 23:32:43 -0800 (PST)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NDljC3bHLzmW1g;
        Sat, 19 Nov 2022 15:32:15 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (7.193.23.242) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 19 Nov 2022 15:32:41 +0800
Received: from [10.67.103.231] (10.67.103.231) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 19 Nov 2022 15:32:40 +0800
Message-ID: <1156ef89-20a4-7e7e-6205-c68e21a9bb36@huawei.com>
Date:   Sat, 19 Nov 2022 15:32:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC] ACPI: PCC: Support shared interrupt for multiple subspaces
To:     Robbie King <robbiek@xsightlabs.com>,
        Sudeep Holla <sudeep.holla@arm.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rafael@kernel.org>, <rafael.j.wysocki@intel.com>,
        <wanghuiqiang@huawei.com>, <huangdaode@huawei.com>,
        <tanxiaofei@huawei.com>
References: <20221016034043.52227-1-lihuisong@huawei.com>
 <20221027155323.7xmpjfrh7qmil6o3@bogus>
 <f0c408a6-cd94-4963-d4d7-e7d08b6150be@huawei.com>
 <20221031104036.bv6a7i6hxrmtpj23@bogus>
 <925f360d-e6b3-6004-de22-f39eaa86a750@huawei.com>
 <d0b178d3-a036-399f-fb0c-bb7f8c52995c@xsightlabs.com>
 <20221104151530.44sms3fnarqnvvsl@bogus>
 <ca35058d-1f40-3f85-9e2d-bfb29c8625cb@xsightlabs.com>
 <09e0a108-9f22-a9a0-2145-a81936745887@huawei.com>
 <3b28294a-1e2b-140a-8462-5014ba893cc5@xsightlabs.com>
From:   "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <3b28294a-1e2b-140a-8462-5014ba893cc5@xsightlabs.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.231]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/11/18 2:09, Robbie King 写道:
> On 11/7/2022 1:24 AM, lihuisong (C) wrote:
>>
>> 在 2022/11/4 23:39, Robbie King 写道:
>>> On 11/4/2022 11:15 AM, Sudeep Holla wrote:
>>>> On Fri, Nov 04, 2022 at 11:04:22AM -0400, Robbie King wrote:
>>>>> Hello Huisong, your raising of the shared interrupt issue is very 
>>>>> timely, I
>>>>> am working to implement "Extended PCC subspaces (types 3 and 4)" 
>>>>> using PCC
>>>>> on the ARM RDN2 reference platform as a proof of concept, and 
>>>>> encountered
>>>>> this issue as well.  FWIW, I am currently testing using Sudeep's 
>>>>> patch with
>>>>> the "chan_in_use" flag removed, and so far have not encountered 
>>>>> any issues.
>>>>>
>>>>
>>>> Interesting, do you mean the patch I post in this thread but 
>>>> without the
>>>> whole chan_in_use flag ?
>>>
>>> That's right, diff I'm running with is attached to end of message.
>> Hello Robbie, In multiple subspaces scenario, there is a problem
>> that OS doesn't know which channel should respond to the interrupt
>> if no this chan_in_use flag. If you have not not encountered any
>> issues in this case, it may be related to your register settings.
>>
>
> Hi Huisong, apologies, I see your point now concerning multiple 
> subspaces.
>
> I have started stress testing where I continuously generate both requests
> and notifications as quickly as possible, and unfortunately found an 
> issue
> even with the original chan_in_use patch.  I first had to modify the 
> patch
> to get the type 4 channel notifications to function at all, essentially
> ignoring the chan_in_use flag for that channel.  With that change, I 
> still
> hit my original stress issue, where the pcc_mbox_irq function did not
> correctly ignore an interrupt for the type 3 channel.
>
> The issue occurs when a request from AP to SCP over the type 3 channel is
> outstanding, and simultaneously the SCP initiates a notification over the
> type 4 channel.  Since the two channels share an interrupt, both handlers
> are invoked.
>
> I've tried to draw out the state of the channel status "free" bits along
> with the AP and SCP function calls involved.
>
> type 3
> ------
>
>  (1)pcc.c:pcc_send_data()
>        |                         (5) mailbox.c:mbox_chan_receive_data()
> _______v                      (4)pcc.c:pcc_mbox_irq()
> free   \_________________________________________
>
>                               ^
> type 4                        ^
> ------                        ^
> _____________________
> free                 \_____________________________
>                      ^        ^
>                      |        |
> (2)mod_smt.c:smt_transmit()   |
>                               |
> (3)mod_mhu2.c:raise_interrupt()
>
> The sequence of events are:
>
> 1) OS initiates request to SCP by clearing FREE in status and ringing 
> SCP doorbell
> 2) SCP initiates notification by filling shared memory and clearing 
> FREE in status
> 3) SCP notifies OS by ringing OS doorbell
> 4) OS first invokes interrupt handler for type 3 channel
>
>    At this step, the issue is that "val" from reading status (i.e. 
> CommandCompleteCheck)
>    is zero (SCP has not responded yet) so the code below falls through 
> and continues
>    to processes the interrupt as if the request has been acknowledged 
> by the SCP.
>
>     if (val) { /* Ensure GAS exists and value is non-zero */
>         val &= pchan->cmd_complete.status_mask;
>         if (!val)
>             return IRQ_NONE;
>     }
>
>    The chan_in_use flag does not address this because the channel is 
> indeed in use.
>
> 5) ACPI:PCC client kernel module is incorrectly notified that response 
> data is
>    available
Indeed, chan_in_use flag is invalid for type4.
> I added the following fix (applied on top of Sudeep's original patch 
> for clarity)
> for the issue above which solved the stress test issue.  I've changed 
> the interrupt
> handler to explicitly verify that the status value matches the mask 
> for type 3
> interrupts before acknowledging them.  Conversely, a type 4 channel 
> verifies that
> the status value does *not* match the mask, since in this case we are 
> functioning
> as the recipient, not the initiator.
>
> One concern is that since this fundamentally changes handling of the 
> channel status,
> that existing platforms could be impacted.
[snip]
>
> +    /*
> +     * When we control data flow on the channel, we expect
> +     * to see the mask bit(s) set by the remote to indicate
> +     * the presence of a valid response.  When we do not
> +     * control the flow (i.e. type 4) the opposite is true.
> +     */
> +    if (pchan->is_controller)
> +        cmp = pchan->cmd_complete.status_mask;
> +    else
> +        cmp = 0;
> +
> +    val &= pchan->cmd_complete.status_mask;
> +    if (cmp != val)
> +        return IRQ_NONE;
>
We don't have to use the pchan->cmd_complete.status_mask as above.

For the communication from AP to SCP, if this channel is in use, command
complete bit is 1 indicates that the command being executed has been
completed.
For the communication from SCP to AP, if this channel is in use, command
complete bit is 0 indicates that the bit has been cleared and OS should
response the interrupt.

So you concern should be gone if we do as following approach:
"
val &= pchan->cmd_complete.status_mask;
need_rsp_irq = pchan->is_controller ? val != 0 : val == 0;
if (!need_rsp_irq)
     return IRQ_NONE
"

This may depend on the default value of the command complete register
for each channel(must be 1, means that the channel is free for use).
It is ok for type3 because of chan_in_use flag, while something needs
to do in platform or OS for type4.
> ret = pcc_chan_reg_read(&pchan->error, &val);
>      if (ret)
> @@ -704,6 +717,9 @@ static int pcc_mbox_probe(struct platform_device 
> *pdev)
>          pcc_mbox_channels[i].con_priv = pchan;
>          pchan->chan.mchan = &pcc_mbox_channels[i];
>
> +        pchan->is_controller =
> +            (pcct_entry->type != ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE);
> +
This definition does not apply to all types because type1 and type2
support bidirectional communication.

> if (pcct_entry->type == ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE &&
>              !pcc_mbox_ctrl->txdone_irq) {
>              pr_err("Plaform Interrupt flag must be set to 1");
>

I put all points we discussed into the following modifcation.
Robbie, can you try it again for type 4 and see what else needs to be
done?

Regards,
Huisong

--> all modifcations:
diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 3c2bc0ca454c..320aab6cf733 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -80,6 +80,13 @@ struct pcc_chan_reg {
         u64 status_mask;
  };

+enum pcc_chan_mesg_dir {
+       PCC_ONLY_AP_TO_SCP,
+       PCC_ONLY_SCP_TO_AP,
+       PCC_BIDIRECTIONAL,
+       PCC_DIR_UNKNOWN,
+};
+
  /**
   * struct pcc_chan_info - PCC channel specific information
   *
@@ -91,6 +98,10 @@ struct pcc_chan_reg {
   * @cmd_update: PCC register bundle for the command complete update 
register
   * @error: PCC register bundle for the error status register
   * @plat_irq: platform interrupt
+ * @plat_irq_flags: platform interrupt flags
+ * @chan_in_use: flag indicating whether the channel is in use or not 
when use
+ *               platform interrupt
+ * @mesg_dir: direction of message transmission supported by the channel
   */
  struct pcc_chan_info {
         struct pcc_mbox_chan chan;
@@ -100,6 +111,9 @@ struct pcc_chan_info {
         struct pcc_chan_reg cmd_update;
         struct pcc_chan_reg error;
         int plat_irq;
+       unsigned int plat_irq_flags;
+       bool chan_in_use;
+       u8 mesg_dir;
  };

  #define to_pcc_chan_info(c) container_of(c, struct pcc_chan_info, chan)
@@ -221,6 +235,47 @@ static int pcc_map_interrupt(u32 interrupt, u32 flags)
         return acpi_register_gsi(NULL, interrupt, trigger, polarity);
  }

+static bool pcc_chan_plat_irq_can_be_shared(struct pcc_chan_info *pchan)
+{
+       return (pchan->plat_irq_flags & ACPI_PCCT_INTERRUPT_MODE) ==
+               ACPI_LEVEL_SENSITIVE;
+}
+
+static bool pcc_chan_need_rsp_irq(struct pcc_chan_info *pchan,
+                                 u64 cmd_complete_reg_val)
+{
+       bool need_rsp;
+
+       if (!pchan->cmd_complete.gas)
+               return true;
+
+       cmd_complete_reg_val &= pchan->cmd_complete.status_mask;
+
+       switch (pchan->mesg_dir) {
+       case PCC_ONLY_AP_TO_SCP:
+               /*
+                * For the communication from AP to SCP, if this channel 
is in
+                * use, command complete bit is 1 indicates that the command
+                * being executed has been completed.
+                */
+               need_rsp = cmd_complete_reg_val != 0;
+               break;
+       case PCC_ONLY_SCP_TO_AP:
+               /*
+                * For the communication from SCP to AP， if this channel 
is in
+                * use, command complete bit is 0 indicates that the bit has
+                * been cleared and AP should response the interrupt.
+                */
+               need_rsp = cmd_complete_reg_val == 0;
+               break;
+       default:
+               need_rsp = true;
+               break;
+       }
+
+       return need_rsp;
+}
+
  /**
   * pcc_mbox_irq - PCC mailbox interrupt handler
   * @irq:       interrupt number
@@ -232,37 +287,47 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
  {
         struct pcc_chan_info *pchan;
         struct mbox_chan *chan = p;
+       static irqreturn_t rc;
         u64 val;
         int ret;

         pchan = chan->con_priv;
+       if (pchan->mesg_dir == PCC_ONLY_AP_TO_SCP && !pchan->chan_in_use)
+               return IRQ_NONE;

         ret = pcc_chan_reg_read(&pchan->cmd_complete, &val);
         if (ret)
                 return IRQ_NONE;
+       if (!pcc_chan_need_rsp_irq(pchan, val))
+               return IRQ_NONE;

-       if (val) { /* Ensure GAS exists and value is non-zero */
-               val &= pchan->cmd_complete.status_mask;
-               if (!val)
-                       return IRQ_NONE;
+       ret = pcc_chan_reg_read(&pchan->error, &val);
+       if (ret) {
+               rc = IRQ_NONE;
+               goto out;
         }

-       ret = pcc_chan_reg_read(&pchan->error, &val);
-       if (ret)
-               return IRQ_NONE;
         val &= pchan->error.status_mask;
         if (val) {
                 val &= ~pchan->error.status_mask;
                 pcc_chan_reg_write(&pchan->error, val);
-               return IRQ_NONE;
+               rc = IRQ_NONE;
+               goto out;
         }

-       if (pcc_chan_reg_read_modify_write(&pchan->plat_irq_ack))
-               return IRQ_NONE;
+       if (pcc_chan_reg_read_modify_write(&pchan->plat_irq_ack)) {
+               rc = IRQ_NONE;
+               goto out;
+       }

         mbox_chan_received_data(chan, NULL);
+       rc = IRQ_HANDLED;

-       return IRQ_HANDLED;
+out:
+       if (pchan->cmd_complete.gas)
+               pchan->chan_in_use = false;
+
+       return rc;
  }

  /**
@@ -309,10 +374,13 @@ pcc_mbox_request_channel(struct mbox_client *cl, 
int subspace_id)
         spin_unlock_irqrestore(&chan->lock, flags);

         if (pchan->plat_irq > 0) {
+               unsigned long irqflags;
                 int rc;

-               rc = devm_request_irq(dev, pchan->plat_irq, pcc_mbox_irq, 0,
-                                     MBOX_IRQ_NAME, chan);
+               irqflags = pcc_chan_plat_irq_can_be_shared(pchan) ?
+                               IRQF_SHARED | IRQF_ONESHOT : 0;
+               rc = devm_request_irq(dev, pchan->plat_irq, pcc_mbox_irq,
+                                     irqflags, MBOX_IRQ_NAME, chan);
                 if (unlikely(rc)) {
                         dev_err(dev, "failed to register PCC interrupt 
%d\n",
                                 pchan->plat_irq);
@@ -374,7 +442,11 @@ static int pcc_send_data(struct mbox_chan *chan, 
void *data)
         if (ret)
                 return ret;

-       return pcc_chan_reg_read_modify_write(&pchan->db);
+       ret = pcc_chan_reg_read_modify_write(&pchan->db);
+       if (!ret && pchan->plat_irq > 0)
+               pchan->chan_in_use = true;
+
+       return ret;
  }

  static const struct mbox_chan_ops pcc_chan_ops = {
@@ -457,6 +529,7 @@ static int pcc_parse_subspace_irq(struct 
pcc_chan_info *pchan,
                        pcct_ss->platform_interrupt);
                 return -EINVAL;
         }
+       pchan->plat_irq_flags = pcct_ss->flags;

         if (pcct_ss->header.type == 
ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2) {
                 struct acpi_pcct_hw_reduced_type2 *pcct2_ss = (void 
*)pcct_ss;
@@ -478,6 +551,12 @@ static int pcc_parse_subspace_irq(struct 
pcc_chan_info *pchan,
                                         "PLAT IRQ ACK");
         }

+       if (pcc_chan_plat_irq_can_be_shared(pchan) &&
+           !pchan->plat_irq_ack.gas) {
+               pr_err("PCC subspace has level IRQ with no ACK register\n");
+               return -EINVAL;
+       }
+
         return ret;
  }

@@ -613,6 +692,18 @@ static int __init acpi_pcc_probe(void)
         return rc;
  }

+static void pcc_set_chan_mesg_dir(struct pcc_chan_info *pchan, u8 type)
+{
+       if (type <= ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2)
+               pchan->mesg_dir = PCC_BIDIRECTIONAL;
+       else if (type == ACPI_PCCT_TYPE_EXT_PCC_MASTER_SUBSPACE)
+               pchan->mesg_dir = PCC_ONLY_AP_TO_SCP;
+       else if (type == ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE)
+               pchan->mesg_dir = PCC_ONLY_SCP_TO_AP;
+       else
+               pchan->mesg_dir = PCC_DIR_UNKNOWN;
+}
+
  /**
   * pcc_mbox_probe - Called when we find a match for the
   *     PCCT platform device. This is purely used to represent
@@ -680,6 +771,7 @@ static int pcc_mbox_probe(struct platform_device *pdev)
                         rc = -EINVAL;
                         goto err;
                 }
+               pcc_set_chan_mesg_dir(pchan, pcct_entry->type);

                 if (pcc_mbox_ctrl->txdone_irq) {
                         rc = pcc_parse_subspace_irq(pchan, pcct_entry);

> .
