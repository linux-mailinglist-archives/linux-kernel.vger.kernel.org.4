Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDAF460048C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 02:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiJQAhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 20:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiJQAhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 20:37:14 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456D734707;
        Sun, 16 Oct 2022 17:37:13 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 8CF256404F8;
        Mon, 17 Oct 2022 00:37:12 +0000 (UTC)
Received: from pdx1-sub0-mail-a225 (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id DA6DB64048D;
        Mon, 17 Oct 2022 00:37:11 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1665967032; a=rsa-sha256;
        cv=none;
        b=IWJhjxweL2XMmCjj2fCo7OMwD2atjkmSiCi41LKCyRyy+Qmci0tb7bDKg4/XzGmDQkl0z7
        ScWpgGyPk6G+oEHmVkwgIRTEfXtHfh1sfUKDMP2Kwqd7h1KTwKizxI+lLM3yF9Rvgoq1/3
        frs6inqde64A72qZ9W8FsWciavO3o4t6ROukIhilHmdadOANewbO8QQetzKxAxT0WMpmNB
        l4R5KqQUvvg8EiYi9bRZ34sZdWCkd5Yfb7LeuX9Rp/Y7xhYaLevWKUWBV6PVR+dSy0mJ1K
        SHV9FnL8TBDKjAoX3ngQkHN5UEjaLujxJf+WrKuWJ9YSaLFz+QByDWFcTAutMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1665967032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=jY+33SlDVLvaMAKSfkzLIl5+sx/OdWa5EnT9h5u3AUk=;
        b=wNdmZFSRzYO8CzMN3PcpXUPypWNwvC8jfrWu52KOz2w8aebrvZmzfqs6C6O5+F2LDzC27i
        8iRrsQUIpMUxySdJp5yomhh1oxEG/pe28QZ9gcGZk7dzhU1Xp0DJkThFVUxPWJQU32VhbU
        n12aUs+6ucrNohvD0YQgjq0XXDFYPFA/14KJJ8NCEelDgCLX8sKfculp3clprrd0zoFiTw
        WWHrWRxWDlnDknw8479W9u/d6BmckEVy8WSdy3K8pgM+yMAu4V5A3uoi1i26kASGBkpjWW
        tLApRDek2NL1JnLxYuYZZ6OqMH8QbEHToyLBNpwLOLPIUDqPHMqVHKPZ5tk9bQ==
ARC-Authentication-Results: i=1;
        rspamd-7fb88f4dd5-7rkzh;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Trail-White: 73b3c082385bd231_1665967032361_2724293366
X-MC-Loop-Signature: 1665967032361:2128392776
X-MC-Ingress-Time: 1665967032361
Received: from pdx1-sub0-mail-a225 (pop.dreamhost.com [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.122.213.136 (trex/6.7.1);
        Mon, 17 Oct 2022 00:37:12 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a225 (Postfix) with ESMTPSA id 4MrJ3V5R7mz28;
        Sun, 16 Oct 2022 17:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1665967031;
        bh=jY+33SlDVLvaMAKSfkzLIl5+sx/OdWa5EnT9h5u3AUk=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=S72vLOcvxWUnfHWm1OsyhtSCqQuVVluf1qvGJ3lU/OSBLowP1VRhT7aDuT6SMmCIF
         9MIKWqDsE4zuG1UObKW2FwV5W36nS1UhpGHyOZFeFVMVZgIkqO6rvfpLjEC4CUCGK+
         idtgF5drJGohhvKk4RgM7IlHio6JvpLrQ//dA4eXovh6OSudsPWabQJdy+CY2LaEAx
         cLmzmp3yLntMKDsZikQL61jDVxqQ16aNeoM+B/fP6NlmjJmDqQ6Ou6nqoAPNCx5XWJ
         DD0kSeXcAtivMOotxkke86T3wgGbrDkSDX0UadWjY1Rn6OcHT9+Ih44S984H1//nGN
         3CJFBfQWYoe5w==
Date:   Sun, 16 Oct 2022 17:37:07 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
        dave.jiang@intel.com, alison.schofield@intel.com,
        vishal.l.verma@intel.com, bwidawsk@kernel.org,
        a.manzanares@samsung.com, linux-kernel@vger.kernel.org,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH 1/2] cxl/pci: Add generic MSI/MSI-X interrupt support
Message-ID: <20221017003707.e73mh2ezre52xqvd@offworld>
References: <20221014194930.2630416-1-dave@stgolabs.net>
 <20221014194930.2630416-2-dave@stgolabs.net>
 <Y0yBbjJgqyBS+viw@iweiny-desk3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Y0yBbjJgqyBS+viw@iweiny-desk3>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Oct 2022, Ira Weiny wrote:

>> +enum {
>> +	CXL_IRQ_NONE,
>> +	CXL_IRQ_MSI,
>> +};
>
>I don't recall this being in v1?

No, it wasn't. I added it because it was a clean way of doing the irq setup
for each interested party in it's own setup call (such as I do in patch 2).
Jonathan preferred it this way... but per all the below, it seems actually
better to stick with the original plan and do the request_irq for all
interested parties at once, after a succesful call to cxl_pci_alloc_irq_vectors().

>
>Right now do we have any users who will register irq's without having MSI
>support?

We don't, and as you know, the fw interrupts thing is only for events; so
actually if we were to have any kind of flags, I guess a cxlds->has_msi
boolean would do, instead of the enum. But the below voids this I guess.

>
>> +
>>  /* CXL 2.0 8.2.8.1 Device Capabilities Array Register */
>>  #define CXLDEV_CAP_ARRAY_OFFSET 0x0
>>  #define   CXLDEV_CAP_ARRAY_CAP_ID 0
>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>> index 88e3a8e54b6a..ca020767f7fc 100644
>> --- a/drivers/cxl/cxlmem.h
>> +++ b/drivers/cxl/cxlmem.h
>> @@ -247,6 +247,8 @@ struct cxl_dev_state {
>>
>>	struct xarray doe_mbs;
>>
>> +	int irq_type;
>> +
>>	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
>>  };
>>
>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>> index faeb5d9d7a7a..942c4449d30f 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -428,6 +428,67 @@ static void devm_cxl_pci_create_doe(struct cxl_dev_state *cxlds)
>>	}
>>  }
>>
>> +/**
>> + * struct cxl_irq_cap - CXL feature that is capable of receiving MSI/MSI-X irqs.
>> + *
>> + * @name: Name of the device generating this interrupt.
>> + * @get_max_msgnum: Get the feature's largest interrupt message number.  If the
>> + *		    feature does not have the Interrupt Supported bit set, then
>> + *		    return -1.
>> + */
>> +struct cxl_irq_cap {
>> +	const char *name;
>> +	int (*get_max_msgnum)(struct cxl_dev_state *cxlds);
>> +};
>> +
>> +static const struct cxl_irq_cap cxl_irq_cap_table[] = { NULL };
>> +
>> +static void cxl_pci_free_irq_vectors(void *data)
>> +{
>> +	pci_free_irq_vectors(data);
>> +}
>> +
>> +/*
>> + * Attempt to allocate the largest amount of necessary vectors.
>> + *
>> + * Returns 0 upon a successful allocation of *all* vectors, or a
>> + * negative value otherwise.
>> + */
>> +static int cxl_pci_alloc_irq_vectors(struct cxl_dev_state *cxlds)
>> +{
>> +	struct device *dev = cxlds->dev;
>> +	struct pci_dev *pdev = to_pci_dev(dev);
>> +	int rc, i, vectors = -1;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(cxl_irq_cap_table); i++) {
>> +		int irq;
>> +
>> +		if (!cxl_irq_cap_table[i].get_max_msgnum)
>> +			continue;
>> +
>> +		irq = cxl_irq_cap_table[i].get_max_msgnum(cxlds);
>> +		vectors = max_t(int, irq, vectors);
>> +	}
>> +
>> +	if (vectors == -1)
>> +		return -1;
>> +
>> +	vectors++;
>> +	rc = pci_alloc_irq_vectors(pdev, vectors, vectors,
>> +				   PCI_IRQ_MSIX | PCI_IRQ_MSI);
>
>Yea without PCI_IRQ_LEGACY I don't think we need any communication about which
>type of vectors were allocated.
>
>Basically if cxl_pci_alloc_irq_vectors() is successful all users can assume
>that at least MSI is available...

Agreed, and that's why I added the flag to indicate to the users if the previous
cxl_pci_alloc_irq_vectors() call had been successful or not, basically to avoid
having them unnecessarily attempt to install their isr. But again all this was
because the request_irq() calls were now going to be in each component setup.

>
>For the mailboxes they could key off of the message number being set in cxlds.
>
>> +	if (rc < 0)
>> +		return rc;
>> +
>> +	if (rc != vectors) {
>> +		dev_err(dev, "Not enough interrupts; use polling instead.\n");
>> +		/* some got allocated, clean them up */
>> +		cxl_pci_free_irq_vectors(pdev);
>> +		return -ENOSPC;
>> +	}
>> +
>> +	return devm_add_action_or_reset(dev, cxl_pci_free_irq_vectors, pdev);
>> +}
>> +
>>  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>  {
>>	struct cxl_register_map map;
>> @@ -478,6 +539,11 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>
>>	devm_cxl_pci_create_doe(cxlds);
>>
>> +	if (!cxl_pci_alloc_irq_vectors(cxlds))
>
>This can't be here for the event stuff because I need the mailboxes set up to
>find out the message numbers for those events.  I had a hell of a time by
>accident putting it here.  :-(

I'm fine with putting this back down, right before the devm_cxl_add_memdev().

>
>> +		cxlds->irq_type = CXL_IRQ_MSI;
>> +	else
>> +		cxlds->irq_type = CXL_IRQ_NONE;
>> +
>>	rc = cxl_pci_setup_mailbox(cxlds);
>>	if (rc)
>>		return rc;
>
>Can't the mailbox irq's be set up after this call?  Mailbox access during set
>up is probably fine using polling, right?

Again, fine by me. So we'd end up in the original:

if (!cxl_pci_alloc_irq_vectors(cxlds)) {
    cxl_mbox_setup_irq();
    cxl_events_setup_irq();
    cxl_pmu_setup_irq();
}

Thanks,
Davidlohr
