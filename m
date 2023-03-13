Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272C26B818F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 20:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjCMTQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 15:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjCMTQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 15:16:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3F93E087
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 12:15:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 329F5B811F6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 19:14:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1495C433EF;
        Mon, 13 Mar 2023 19:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678734888;
        bh=DOBzOLTykg4Bkts9SRDACUFbbp1KDjxkPfQPMcCP18w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=LQI8Wgo4qhThtvauuC6XvG65lxvonNFQFqdRrsxchQXe9PPFpAI3iMLTZT+nKtnVV
         EYUWcs5eS9InwwxsnR7gOmd3cVpl27ZNdtJ3ssCkgYBNe7ufzTfhBwTb04l9xyOFS9
         XypQqaZvlnV7Kq8Is75m6P0Cy2dry0h7xboIg0yUiOxNHI3Y6JWLdOxlA1dEtJ+z4e
         OxRFsExFjj5PxgW8bLeaUwraAbpon6eMWoprcn/zzvpnRmQFP/rjrPATHXdlf7wsmg
         tGBnj5pXZ42erj1AmND+mZGX6Medny9opHW5e5BvGYLGK+OPvo7DeZ97qWKHLM87KM
         dVEsdJdDHAv/w==
Date:   Mon, 13 Mar 2023 14:14:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alex Shi <alexs@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dexuan Cui <decui@microsoft.com>,
        Eric Dumazet <edumazet@google.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Hannes Reinecke <hare@suse.de>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hu Haowen <src.res@email.cn>,
        Ilya Dryomov <idryomov@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Iwona Winiarska <iwona.winiarska@intel.com>,
        Jakub Kicinski <kuba@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paolo Abeni <pabeni@redhat.com>,
        Stuart Yoder <stuyoder@gmail.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Wei Liu <wei.liu@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>
Subject: Re: [PATCH 23/36] driver core: bus: mark the struct bus_type for
 sysfs callbacks as constant
Message-ID: <20230313191447.GA1528028@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313182918.1312597-23-gregkh@linuxfoundation.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 07:29:05PM +0100, Greg Kroah-Hartman wrote:
> struct bus_type should never be modified in a sysfs callback as there is
> nothing in the structure to modify, and frankly, the structure is almost
> never used in a sysfs callback, so mark it as constant to allow struct
> bus_type to be moved to read-only memory.
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: Alex Shi <alexs@kernel.org>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Alexandre Bounine <alex.bou9@gmail.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Ben Widawsky <bwidawsk@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dexuan Cui <decui@microsoft.com>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Harald Freudenberger <freude@linux.ibm.com>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Hu Haowen <src.res@email.cn>
> Cc: Ilya Dryomov <idryomov@gmail.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Iwona Winiarska <iwona.winiarska@intel.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> Cc: Matt Porter <mporter@kernel.crashing.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Stuart Yoder <stuyoder@gmail.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: Yanteng Si <siyanteng@loongson.cn>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# pci

> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index dd0d9d9bc509..ab32a91f287b 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -428,7 +428,7 @@ static ssize_t msi_bus_store(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RW(msi_bus);
>  
> -static ssize_t rescan_store(struct bus_type *bus, const char *buf, size_t count)
> +static ssize_t rescan_store(const struct bus_type *bus, const char *buf, size_t count)
>  {
>  	unsigned long val;
>  	struct pci_bus *b = NULL;
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 7a67611dc5f4..45c3bb039f21 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6679,7 +6679,7 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
>  	}
>  }
>  
> -static ssize_t resource_alignment_show(struct bus_type *bus, char *buf)
> +static ssize_t resource_alignment_show(const struct bus_type *bus, char *buf)
>  {
>  	size_t count = 0;
>  
> @@ -6691,7 +6691,7 @@ static ssize_t resource_alignment_show(struct bus_type *bus, char *buf)
>  	return count;
>  }
>  
> -static ssize_t resource_alignment_store(struct bus_type *bus,
> +static ssize_t resource_alignment_store(const struct bus_type *bus,
>  					const char *buf, size_t count)
>  {
>  	char *param, *old, *end;
