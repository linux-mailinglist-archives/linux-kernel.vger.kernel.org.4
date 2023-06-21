Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C1E738DA8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 19:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjFURus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 13:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbjFURuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 13:50:35 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87511BF4;
        Wed, 21 Jun 2023 10:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687369823; x=1718905823;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FvgO26ZV8KFkH6De3TQgsHq/u7Q2rPq8oBE4FkR4Q30=;
  b=MBjXn4Do7KNVo6cskuVkO43oNWEbvuGU/TIYfP4rVFKxQL83L/jJlmqe
   4L/FqQweTRcYOJfjVY8p0+OQa7p1TP2/JxsIU2Awo/1SMa3i8gfF0jtyB
   ERVOU3TqrVtKtA2EymkRBM06uRQuc2zVh7sClTIOJlGNyHDa+/nops3NZ
   IExn69hWfdmbzihLoWK84fdS8CL/Nf1wJaSJjn0OOKoUGa2MjuH3K0WM2
   /wGcitDFZacgaDCNZhfZgPg+U/mF7OD2I2kK4ESaLREfPHa7oVhuKsgq9
   ngwsKG9oocTnRLkHGqG6LQRH5I/kfIkdjIeNjebkGe1Vro/Pt4qvzxvB3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="357753995"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="357753995"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 10:50:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="664761236"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="664761236"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 21 Jun 2023 10:50:14 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qC1yA-0006zv-02;
        Wed, 21 Jun 2023 17:50:14 +0000
Date:   Thu, 22 Jun 2023 01:49:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Markus Schneider-Pargmann <msp@baylibre.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Simon Horman <simon.horman@corigine.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Julien Panis <jpanis@baylibre.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: Re: [PATCH v4 01/12] can: m_can: Write transmit header and data in
 one transaction
Message-ID: <202306220154.20bzOw90-lkp@intel.com>
References: <20230621092350.3130866-2-msp@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621092350.3130866-2-msp@baylibre.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markus,

kernel test robot noticed the following build warnings:

[auto build test WARNING on ac9a78681b921877518763ba0e89202254349d1b]

url:    https://github.com/intel-lab-lkp/linux/commits/Markus-Schneider-Pargmann/can-m_can-Write-transmit-header-and-data-in-one-transaction/20230621-173848
base:   ac9a78681b921877518763ba0e89202254349d1b
patch link:    https://lore.kernel.org/r/20230621092350.3130866-2-msp%40baylibre.com
patch subject: [PATCH v4 01/12] can: m_can: Write transmit header and data in one transaction
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20230622/202306220154.20bzOw90-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230622/202306220154.20bzOw90-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306220154.20bzOw90-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/can/m_can/m_can.c: In function 'm_can_tx_handler':
>> drivers/net/can/m_can/m_can.c:1635:27: warning: unused variable 'fifo_header' [-Wunused-variable]
    1635 |         struct id_and_dlc fifo_header;
         |                           ^~~~~~~~~~~


vim +/fifo_header +1635 drivers/net/can/m_can/m_can.c

10c1c3975a6663 Mario Huettel             2017-04-08  1627  
441ac340169b79 Dan Murphy                2019-05-09  1628  static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
e0d1f4816f2a7e Dong Aisheng              2014-07-16  1629  {
441ac340169b79 Dan Murphy                2019-05-09  1630  	struct canfd_frame *cf = (struct canfd_frame *)cdev->tx_skb->data;
9a10b9d9f7e946 Markus Schneider-Pargmann 2023-06-21  1631  	u8 len_padded = DIV_ROUND_UP(cf->len, 4);
9a10b9d9f7e946 Markus Schneider-Pargmann 2023-06-21  1632  	struct m_can_fifo_element fifo_element;
441ac340169b79 Dan Murphy                2019-05-09  1633  	struct net_device *dev = cdev->net;
441ac340169b79 Dan Murphy                2019-05-09  1634  	struct sk_buff *skb = cdev->tx_skb;
812270e5445bd1 Matt Kline                2021-08-16 @1635  	struct id_and_dlc fifo_header;
812270e5445bd1 Matt Kline                2021-08-16  1636  	u32 cccr, fdflags;
c1eaf8b9bd3145 Markus Schneider-Pargmann 2022-12-06  1637  	u32 txfqs;
812270e5445bd1 Matt Kline                2021-08-16  1638  	int err;
10c1c3975a6663 Mario Huettel             2017-04-08  1639  	int putidx;
e0d1f4816f2a7e Dong Aisheng              2014-07-16  1640  
e04b2cfe61072c Marc Kleine-Budde         2021-05-05  1641  	cdev->tx_skb = NULL;
e04b2cfe61072c Marc Kleine-Budde         2021-05-05  1642  
10c1c3975a6663 Mario Huettel             2017-04-08  1643  	/* Generate ID field for TX buffer Element */
10c1c3975a6663 Mario Huettel             2017-04-08  1644  	/* Common to all supported M_CAN versions */
e0d1f4816f2a7e Dong Aisheng              2014-07-16  1645  	if (cf->can_id & CAN_EFF_FLAG) {
9a10b9d9f7e946 Markus Schneider-Pargmann 2023-06-21  1646  		fifo_element.id = cf->can_id & CAN_EFF_MASK;
9a10b9d9f7e946 Markus Schneider-Pargmann 2023-06-21  1647  		fifo_element.id |= TX_BUF_XTD;
e0d1f4816f2a7e Dong Aisheng              2014-07-16  1648  	} else {
9a10b9d9f7e946 Markus Schneider-Pargmann 2023-06-21  1649  		fifo_element.id = ((cf->can_id & CAN_SFF_MASK) << 18);
e0d1f4816f2a7e Dong Aisheng              2014-07-16  1650  	}
e0d1f4816f2a7e Dong Aisheng              2014-07-16  1651  
e0d1f4816f2a7e Dong Aisheng              2014-07-16  1652  	if (cf->can_id & CAN_RTR_FLAG)
9a10b9d9f7e946 Markus Schneider-Pargmann 2023-06-21  1653  		fifo_element.id |= TX_BUF_RTR;
e0d1f4816f2a7e Dong Aisheng              2014-07-16  1654  
441ac340169b79 Dan Murphy                2019-05-09  1655  	if (cdev->version == 30) {
10c1c3975a6663 Mario Huettel             2017-04-08  1656  		netif_stop_queue(dev);
10c1c3975a6663 Mario Huettel             2017-04-08  1657  
9a10b9d9f7e946 Markus Schneider-Pargmann 2023-06-21  1658  		fifo_element.dlc = can_fd_len2dlc(cf->len) << 16;
80646733f11c2e Dong Aisheng              2014-11-18  1659  
812270e5445bd1 Matt Kline                2021-08-16  1660  		/* Write the frame ID, DLC, and payload to the FIFO element. */
9a10b9d9f7e946 Markus Schneider-Pargmann 2023-06-21  1661  		err = m_can_fifo_write(cdev, 0, M_CAN_FIFO_ID, &fifo_element, 2);
e39381770ec9ca Matt Kline                2021-08-16  1662  		if (err)
e39381770ec9ca Matt Kline                2021-08-16  1663  			goto out_fail;
e39381770ec9ca Matt Kline                2021-08-16  1664  
812270e5445bd1 Matt Kline                2021-08-16  1665  		err = m_can_fifo_write(cdev, 0, M_CAN_FIFO_DATA,
9a10b9d9f7e946 Markus Schneider-Pargmann 2023-06-21  1666  				       cf->data, len_padded);
e39381770ec9ca Matt Kline                2021-08-16  1667  		if (err)
e39381770ec9ca Matt Kline                2021-08-16  1668  			goto out_fail;
80646733f11c2e Dong Aisheng              2014-11-18  1669  
441ac340169b79 Dan Murphy                2019-05-09  1670  		if (cdev->can.ctrlmode & CAN_CTRLMODE_FD) {
441ac340169b79 Dan Murphy                2019-05-09  1671  			cccr = m_can_read(cdev, M_CAN_CCCR);
20779943a080c5 Torin Cooper-Bennun       2021-05-04  1672  			cccr &= ~CCCR_CMR_MASK;
80646733f11c2e Dong Aisheng              2014-11-18  1673  			if (can_is_canfd_skb(skb)) {
80646733f11c2e Dong Aisheng              2014-11-18  1674  				if (cf->flags & CANFD_BRS)
20779943a080c5 Torin Cooper-Bennun       2021-05-04  1675  					cccr |= FIELD_PREP(CCCR_CMR_MASK,
20779943a080c5 Torin Cooper-Bennun       2021-05-04  1676  							   CCCR_CMR_CANFD_BRS);
80646733f11c2e Dong Aisheng              2014-11-18  1677  				else
20779943a080c5 Torin Cooper-Bennun       2021-05-04  1678  					cccr |= FIELD_PREP(CCCR_CMR_MASK,
20779943a080c5 Torin Cooper-Bennun       2021-05-04  1679  							   CCCR_CMR_CANFD);
80646733f11c2e Dong Aisheng              2014-11-18  1680  			} else {
20779943a080c5 Torin Cooper-Bennun       2021-05-04  1681  				cccr |= FIELD_PREP(CCCR_CMR_MASK, CCCR_CMR_CAN);
80646733f11c2e Dong Aisheng              2014-11-18  1682  			}
441ac340169b79 Dan Murphy                2019-05-09  1683  			m_can_write(cdev, M_CAN_CCCR, cccr);
80646733f11c2e Dong Aisheng              2014-11-18  1684  		}
441ac340169b79 Dan Murphy                2019-05-09  1685  		m_can_write(cdev, M_CAN_TXBTIE, 0x1);
2e8e79c416aae1 Marc Kleine-Budde         2022-03-17  1686  
2e8e79c416aae1 Marc Kleine-Budde         2022-03-17  1687  		can_put_echo_skb(skb, dev, 0, 0);
2e8e79c416aae1 Marc Kleine-Budde         2022-03-17  1688  
441ac340169b79 Dan Murphy                2019-05-09  1689  		m_can_write(cdev, M_CAN_TXBAR, 0x1);
10c1c3975a6663 Mario Huettel             2017-04-08  1690  		/* End of xmit function for version 3.0.x */
10c1c3975a6663 Mario Huettel             2017-04-08  1691  	} else {
10c1c3975a6663 Mario Huettel             2017-04-08  1692  		/* Transmit routine for version >= v3.1.x */
10c1c3975a6663 Mario Huettel             2017-04-08  1693  
c1eaf8b9bd3145 Markus Schneider-Pargmann 2022-12-06  1694  		txfqs = m_can_read(cdev, M_CAN_TXFQS);
c1eaf8b9bd3145 Markus Schneider-Pargmann 2022-12-06  1695  
10c1c3975a6663 Mario Huettel             2017-04-08  1696  		/* Check if FIFO full */
c1eaf8b9bd3145 Markus Schneider-Pargmann 2022-12-06  1697  		if (_m_can_tx_fifo_full(txfqs)) {
10c1c3975a6663 Mario Huettel             2017-04-08  1698  			/* This shouldn't happen */
10c1c3975a6663 Mario Huettel             2017-04-08  1699  			netif_stop_queue(dev);
10c1c3975a6663 Mario Huettel             2017-04-08  1700  			netdev_warn(dev,
10c1c3975a6663 Mario Huettel             2017-04-08  1701  				    "TX queue active although FIFO is full.");
441ac340169b79 Dan Murphy                2019-05-09  1702  
441ac340169b79 Dan Murphy                2019-05-09  1703  			if (cdev->is_peripheral) {
f524f829b75a7d Dan Murphy                2019-05-09  1704  				kfree_skb(skb);
f524f829b75a7d Dan Murphy                2019-05-09  1705  				dev->stats.tx_dropped++;
f524f829b75a7d Dan Murphy                2019-05-09  1706  				return NETDEV_TX_OK;
f524f829b75a7d Dan Murphy                2019-05-09  1707  			} else {
10c1c3975a6663 Mario Huettel             2017-04-08  1708  				return NETDEV_TX_BUSY;
10c1c3975a6663 Mario Huettel             2017-04-08  1709  			}
f524f829b75a7d Dan Murphy                2019-05-09  1710  		}
10c1c3975a6663 Mario Huettel             2017-04-08  1711  
10c1c3975a6663 Mario Huettel             2017-04-08  1712  		/* get put index for frame */
c1eaf8b9bd3145 Markus Schneider-Pargmann 2022-12-06  1713  		putidx = FIELD_GET(TXFQS_TFQPI_MASK, txfqs);
812270e5445bd1 Matt Kline                2021-08-16  1714  
812270e5445bd1 Matt Kline                2021-08-16  1715  		/* Construct DLC Field, with CAN-FD configuration.
812270e5445bd1 Matt Kline                2021-08-16  1716  		 * Use the put index of the fifo as the message marker,
812270e5445bd1 Matt Kline                2021-08-16  1717  		 * used in the TX interrupt for sending the correct echo frame.
812270e5445bd1 Matt Kline                2021-08-16  1718  		 */
10c1c3975a6663 Mario Huettel             2017-04-08  1719  
10c1c3975a6663 Mario Huettel             2017-04-08  1720  		/* get CAN FD configuration of frame */
10c1c3975a6663 Mario Huettel             2017-04-08  1721  		fdflags = 0;
10c1c3975a6663 Mario Huettel             2017-04-08  1722  		if (can_is_canfd_skb(skb)) {
10c1c3975a6663 Mario Huettel             2017-04-08  1723  			fdflags |= TX_BUF_FDF;
10c1c3975a6663 Mario Huettel             2017-04-08  1724  			if (cf->flags & CANFD_BRS)
10c1c3975a6663 Mario Huettel             2017-04-08  1725  				fdflags |= TX_BUF_BRS;
10c1c3975a6663 Mario Huettel             2017-04-08  1726  		}
10c1c3975a6663 Mario Huettel             2017-04-08  1727  
9a10b9d9f7e946 Markus Schneider-Pargmann 2023-06-21  1728  		fifo_element.dlc = FIELD_PREP(TX_BUF_MM_MASK, putidx) |
e39381770ec9ca Matt Kline                2021-08-16  1729  			FIELD_PREP(TX_BUF_DLC_MASK, can_fd_len2dlc(cf->len)) |
e39381770ec9ca Matt Kline                2021-08-16  1730  			fdflags | TX_BUF_EFC;
10c1c3975a6663 Mario Huettel             2017-04-08  1731  
9a10b9d9f7e946 Markus Schneider-Pargmann 2023-06-21  1732  		memcpy_and_pad(fifo_element.data, CANFD_MAX_DLEN, &cf->data,
9a10b9d9f7e946 Markus Schneider-Pargmann 2023-06-21  1733  			       cf->len, 0);
9a10b9d9f7e946 Markus Schneider-Pargmann 2023-06-21  1734  
9a10b9d9f7e946 Markus Schneider-Pargmann 2023-06-21  1735  		err = m_can_fifo_write(cdev, putidx, M_CAN_FIFO_ID,
9a10b9d9f7e946 Markus Schneider-Pargmann 2023-06-21  1736  				       &fifo_element, 2 + len_padded);
e39381770ec9ca Matt Kline                2021-08-16  1737  		if (err)
e39381770ec9ca Matt Kline                2021-08-16  1738  			goto out_fail;
10c1c3975a6663 Mario Huettel             2017-04-08  1739  
10c1c3975a6663 Mario Huettel             2017-04-08  1740  		/* Push loopback echo.
10c1c3975a6663 Mario Huettel             2017-04-08  1741  		 * Will be looped back on TX interrupt based on message marker
10c1c3975a6663 Mario Huettel             2017-04-08  1742  		 */
1dcb6e57db8334 Vincent Mailhol           2021-01-11  1743  		can_put_echo_skb(skb, dev, putidx, 0);
10c1c3975a6663 Mario Huettel             2017-04-08  1744  
10c1c3975a6663 Mario Huettel             2017-04-08  1745  		/* Enable TX FIFO element to start transfer  */
441ac340169b79 Dan Murphy                2019-05-09  1746  		m_can_write(cdev, M_CAN_TXBAR, (1 << putidx));
10c1c3975a6663 Mario Huettel             2017-04-08  1747  
10c1c3975a6663 Mario Huettel             2017-04-08  1748  		/* stop network queue if fifo full */
441ac340169b79 Dan Murphy                2019-05-09  1749  		if (m_can_tx_fifo_full(cdev) ||
10c1c3975a6663 Mario Huettel             2017-04-08  1750  		    m_can_next_echo_skb_occupied(dev, putidx))
10c1c3975a6663 Mario Huettel             2017-04-08  1751  			netif_stop_queue(dev);
10c1c3975a6663 Mario Huettel             2017-04-08  1752  	}
e0d1f4816f2a7e Dong Aisheng              2014-07-16  1753  
e0d1f4816f2a7e Dong Aisheng              2014-07-16  1754  	return NETDEV_TX_OK;
e39381770ec9ca Matt Kline                2021-08-16  1755  
e39381770ec9ca Matt Kline                2021-08-16  1756  out_fail:
e39381770ec9ca Matt Kline                2021-08-16  1757  	netdev_err(dev, "FIFO write returned %d\n", err);
e39381770ec9ca Matt Kline                2021-08-16  1758  	m_can_disable_all_interrupts(cdev);
e39381770ec9ca Matt Kline                2021-08-16  1759  	return NETDEV_TX_BUSY;
e0d1f4816f2a7e Dong Aisheng              2014-07-16  1760  }
e0d1f4816f2a7e Dong Aisheng              2014-07-16  1761  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
